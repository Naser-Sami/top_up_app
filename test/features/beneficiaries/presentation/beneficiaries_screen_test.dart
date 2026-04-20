import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_up_app/features/beneficiaries/domain/entities/beneficiary_entity.dart';
import 'package:top_up_app/features/beneficiaries/presentation/controllers/beneficiary_cubit/beneficiary_cubit.dart';
import 'package:top_up_app/features/beneficiaries/presentation/controllers/beneficiary_cubit/beneficiary_state.dart';
import 'package:top_up_app/features/profile/presentation/controllers/user_cubit/user_state.dart';
import '../../../mock_bloc_utils.dart';
import 'package:top_up_app/features/beneficiaries/presentation/screen/beneficiaries_screen.dart';

import 'package:top_up_app/features/profile/domain/entities/user_entity.dart';
import 'package:top_up_app/features/profile/presentation/controllers/user_cubit/user_cubit.dart';
import 'package:top_up_app/features/history/presentation/controllers/transaction_cubit/transaction_cubit.dart';
import 'package:top_up_app/features/history/presentation/controllers/transaction_cubit/transaction_state.dart';

class MockBeneficiaryCubit extends Mock implements BeneficiaryCubit {}
class MockUserCubit extends Mock implements UserCubit {}
class MockTransactionCubit extends Mock implements TransactionCubit {}

void main() {
  late MockBeneficiaryCubit mockCubit;
  late MockUserCubit mockUserCubit;
  late MockTransactionCubit mockTransactionCubit;

  List<BeneficiaryEntity> makeBeneficiaries(int count) => List.generate(
        count,
        (i) => BeneficiaryEntity(id: 'b$i', nickname: 'Name$i', phoneNumber: '+9715000000$i'),
      );

  setUp(() {
    mockCubit = MockBeneficiaryCubit();
    mockUserCubit = MockUserCubit();
    mockTransactionCubit = MockTransactionCubit();

    // Default return values to avoid errors
    when(() => mockUserCubit.state).thenReturn(UserLoaded(UserEntity(id: 'u1', name: 'Naser', balance: 1000, isVerified: true)));
    when(() => mockTransactionCubit.state).thenReturn(const TransactionLoaded([]));
  });

  Widget buildSubject(BeneficiaryState state) {
    // Use broadcast stream to allow multiple listeners (Selector and Builder)
    whenListen(mockCubit, Stream.value(state).asBroadcastStream(), initialState: state);
    whenListen(mockUserCubit, Stream.value(mockUserCubit.state).asBroadcastStream(), initialState: mockUserCubit.state);
    whenListen(mockTransactionCubit, Stream.value(mockTransactionCubit.state).asBroadcastStream(), initialState: mockTransactionCubit.state);

    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<BeneficiaryCubit>.value(value: mockCubit),
          BlocProvider<UserCubit>.value(value: mockUserCubit),
          BlocProvider<TransactionCubit>.value(value: mockTransactionCubit),
        ],
        child: const BeneficiariesScreen(),
      ),
    );
  }

  group('BeneficiariesScreen', () {
    testWidgets('FAB shows snackbar when 5 beneficiaries exist', (tester) async {
      await tester.pumpWidget(buildSubject(BeneficiaryLoaded(makeBeneficiaries(5))));
      // Wait for layout
      await tester.pump();
      
      // Look for FAB
      final fabFinder = find.byType(FloatingActionButton);
      expect(fabFinder, findsOneWidget);
      
      await tester.tap(fabFinder);
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('renders correct number of beneficiary items', (tester) async {
      await tester.pumpWidget(buildSubject(BeneficiaryLoaded(makeBeneficiaries(3))));
      await tester.pump();
      expect(find.text('Name0'), findsOneWidget);
      expect(find.text('Name1'), findsOneWidget);
      expect(find.text('Name2'), findsOneWidget);
    });
  });
}
