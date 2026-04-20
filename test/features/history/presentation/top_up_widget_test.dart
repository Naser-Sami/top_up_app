import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
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

  final tUser = UserEntity(id: 'u1', name: 'Ahmed', balance: 1500.0, isVerified: true);
  final tBeneficiary = BeneficiaryEntity(id: 'b1', nickname: 'Alice', phoneNumber: '+971501234567');
  final tTransaction = TransactionEntity(
    id: 'tx1', beneficiaryId: 'b1', amount: 50.0, fee: 3.0, createdAt: DateTime.now(),
  );

  setUp(() {
    mockTransactionCubit = MockTransactionCubit();
    mockUserCubit = MockUserCubit();
    mockBeneficiaryCubit = MockBeneficiaryCubit();

    when(() => mockUserCubit.state).thenReturn(UserLoaded(tUser));
    when(() => mockBeneficiaryCubit.state).thenReturn(BeneficiaryLoaded([tBeneficiary]));
    when(() => mockTransactionCubit.state).thenReturn(const TransactionLoaded([]));
  });

  Widget buildSubject() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<TransactionCubit>.value(value: mockTransactionCubit),
          BlocProvider<UserCubit>.value(value: mockUserCubit),
          BlocProvider<BeneficiaryCubit>.value(value: mockBeneficiaryCubit),
        ],
        child: TopUpScreen(beneficiary: tBeneficiary),
      ),
    );
  }

  group('TopUpScreen', () {
    // 5.7a — correct total cost shown
    testWidgets('shows correct total cost (selected amount + AED 3 fee)', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      // Tap AED 50 option
      await tester.tap(find.text('AED 50'));
      await tester.pump();

      // Summary card should show total = 50 + 3 = 53
      expect(find.text('AED 53'), findsOneWidget);
    });

    // 5.7b — error snackbar
    testWidgets('shows error snackbar when TransactionError is emitted', (tester) async {
      final controller = StreamController<TransactionState>();
      addTearDown(controller.close);

      whenListen(
        mockTransactionCubit,
        controller.stream,
        initialState: const TransactionLoaded([]),
      );

      await tester.pumpWidget(buildSubject());

      controller.add(const TransactionError('Insufficient balance.'));
      await tester.pump(); // Trigger listener
      await tester.pump(const Duration(seconds: 1)); // Handle animations

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Insufficient balance.'), findsOneWidget);
    });

    // 5.7c — success feedback (snackbar)
    testWidgets('shows success snackbar when TopUpSuccess is emitted', (tester) async {
      final controller = StreamController<TransactionState>();
      addTearDown(controller.close);

      whenListen(
        mockTransactionCubit,
        controller.stream,
        initialState: const TransactionLoaded([]),
      );

      await tester.pumpWidget(buildSubject());

      controller.add(TopUpSuccess(tTransaction));
      await tester.pump(); // Trigger listener
      await tester.pump(const Duration(seconds: 1)); // Handle animations

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Top up successful!'), findsOneWidget);
    });
  });
}
