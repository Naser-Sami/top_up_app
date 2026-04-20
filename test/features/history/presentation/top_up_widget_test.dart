import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_up_app/features/beneficiaries/domain/entities/beneficiary_entity.dart';
import 'package:top_up_app/features/beneficiaries/presentation/controllers/beneficiary_cubit/beneficiary_cubit.dart';
import 'package:top_up_app/features/beneficiaries/presentation/controllers/beneficiary_cubit/beneficiary_state.dart';
import 'package:top_up_app/features/history/domain/entities/transaction_entity.dart';
import 'package:top_up_app/features/history/presentation/controllers/transaction_cubit/transaction_cubit.dart';
import 'package:top_up_app/features/history/presentation/controllers/transaction_cubit/transaction_state.dart';
import 'package:top_up_app/features/history/presentation/screen/top_up_screen.dart';
import 'package:top_up_app/features/profile/domain/entities/user_entity.dart';
import 'package:top_up_app/features/profile/presentation/controllers/user_cubit/user_cubit.dart';
import 'package:top_up_app/features/profile/presentation/controllers/user_cubit/user_state.dart';
import '../../../mock_bloc_utils.dart';

class MockTransactionCubit extends Mock implements TransactionCubit {}

class MockUserCubit extends Mock implements UserCubit {}

class MockBeneficiaryCubit extends Mock implements BeneficiaryCubit {}

void main() {
  late MockTransactionCubit mockTransactionCubit;
  late MockUserCubit mockUserCubit;
  late MockBeneficiaryCubit mockBeneficiaryCubit;

  final tUser = const UserEntity(
    id: 'u1',
    name: 'Ahmed',
    balance: 1500.0,
    isVerified: true,
  );
  final tBeneficiary = const BeneficiaryEntity(
    id: 'b1',
    nickname: 'Alice',
    phoneNumber: '+971501234567',
  );
  final tTransaction = TransactionEntity(
    id: 'tx1',
    beneficiaryId: 'b1',
    amount: 50.0,
    fee: 3.0,
    createdAt: DateTime.now(),
  );

  setUp(() {
    mockTransactionCubit = MockTransactionCubit();
    mockUserCubit = MockUserCubit();
    mockBeneficiaryCubit = MockBeneficiaryCubit();

    when(() => mockUserCubit.state).thenReturn(UserLoaded(tUser));
    when(() => mockBeneficiaryCubit.state)
        .thenReturn(BeneficiaryLoaded([tBeneficiary]));
    when(() => mockTransactionCubit.state)
        .thenReturn(const TransactionLoaded([]));

    // Default broadcast streams so context.watch / BlocListener can both subscribe
    when(() => mockUserCubit.stream)
        .thenAnswer((_) => Stream.value(UserLoaded(tUser)).asBroadcastStream());
    when(() => mockBeneficiaryCubit.stream).thenAnswer(
      (_) =>
          Stream.value(BeneficiaryLoaded([tBeneficiary])).asBroadcastStream(),
    );
    when(() => mockTransactionCubit.stream).thenAnswer(
      (_) => Stream.value(const TransactionLoaded([])).asBroadcastStream(),
    );
  });

  // GoRouter wrapper so context.pop() inside TopUpScreen resolves correctly.
  Widget buildSubject() {
    final router = GoRouter(
      initialLocation: '/parent/top-up',
      routes: [
        GoRoute(
          path: '/parent',
          builder: (_, __) => const Scaffold(body: SizedBox()),
          routes: [
            GoRoute(
              path: 'top-up',
              builder: (context, _) => MultiBlocProvider(
                providers: [
                  BlocProvider<TransactionCubit>.value(
                      value: mockTransactionCubit),
                  BlocProvider<UserCubit>.value(value: mockUserCubit),
                  BlocProvider<BeneficiaryCubit>.value(
                      value: mockBeneficiaryCubit),
                ],
                child: TopUpScreen(beneficiary: tBeneficiary),
              ),
            ),
          ],
        ),
      ],
    );
    return MaterialApp.router(routerConfig: router);
  }

  group('TopUpScreen', () {
    // 5.7a — correct total cost shown
    testWidgets('shows correct total cost (selected amount + AED 3 fee)',
        (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle(); // wait for GoRouter initial routing

      // Scroll AED 50 into view then tap
      await tester.ensureVisible(find.text('AED 50'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('AED 50'));
      await tester.pump();

      // Summary card should show total = 50 + 3 = 53
      expect(find.text('AED 53'), findsOneWidget);
    });

    // 5.7b — error snackbar
    testWidgets('shows error snackbar when TransactionError is emitted',
        (tester) async {
      final controller = StreamController<TransactionState>.broadcast();
      addTearDown(controller.close);

      whenListen(
        mockTransactionCubit,
        controller.stream,
        initialState: const TransactionLoaded([]),
      );

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      controller.add(const TransactionError('Insufficient balance.'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Insufficient balance.'), findsOneWidget);
    });

    // 5.7c — success snackbar shown before screen pops
    testWidgets('shows success snackbar when TopUpSuccess is emitted',
        (tester) async {
      final controller = StreamController<TransactionState>.broadcast();
      addTearDown(controller.close);

      whenListen(
        mockTransactionCubit,
        controller.stream,
        initialState: const TransactionLoaded([]),
      );

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      controller.add(TopUpSuccess(tTransaction));
      await tester.pump(); // BlocListener fires: showSnackBar + context.pop()
      await tester.pump(const Duration(seconds: 1));

      // SnackBar is queued on the root ScaffoldMessenger before pop resolves.
      // During the route transition both scaffolds are in the tree, so there
      // may be more than one SnackBar widget rendered — check at least one.
      expect(find.byType(SnackBar), findsAtLeastNWidgets(1));
      expect(find.text('Top up successful!'), findsAtLeastNWidgets(1));
    });
  });
}
