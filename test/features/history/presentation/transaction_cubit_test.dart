import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_up_app/core/errors/failure.dart';
import 'package:top_up_app/core/services/use_cases/base_use_case.dart';
import 'package:top_up_app/features/beneficiaries/domain/entities/beneficiary_entity.dart';
import 'package:top_up_app/features/history/domain/entities/transaction_entity.dart';
import 'package:top_up_app/features/history/domain/params/top_up_params.dart';
import 'package:top_up_app/features/history/domain/use_cases/get_transactions_use_case.dart';
import 'package:top_up_app/features/history/domain/use_cases/top_up_use_case.dart';
import 'package:top_up_app/features/history/presentation/controllers/transaction_cubit/transaction_cubit.dart';
import 'package:top_up_app/features/history/presentation/controllers/transaction_cubit/transaction_state.dart';
import 'package:top_up_app/features/profile/domain/entities/user_entity.dart';

class MockGetTransactionsUseCase extends Mock implements GetTransactionsUseCase {}
class MockTopUpUseCase extends Mock implements TopUpUseCase {}

void main() {
  late MockGetTransactionsUseCase mockGetUseCase;
  late MockTopUpUseCase mockTopUpUseCase;
  late TransactionCubit cubit;

  final tUser = const UserEntity(id: 'u1', name: 'Ahmed', balance: 1500.0, isVerified: true);
  final tBeneficiary = const BeneficiaryEntity(id: 'b1', nickname: 'Alice', phoneNumber: '+971501234567');
  final now = DateTime.now();
  final tTransaction = TransactionEntity(id: 'tx1', beneficiaryId: 'b1', amount: 50.0, fee: 3.0, createdAt: now);
  final tList = [tTransaction];

  late TopUpParams tParams;

  setUp(() {
    mockGetUseCase = MockGetTransactionsUseCase();
    mockTopUpUseCase = MockTopUpUseCase();
    cubit = TransactionCubit(
      getTransactionsUseCase: mockGetUseCase,
      topUpUseCase: mockTopUpUseCase,
    );
    tParams = TopUpParams(
      user: tUser,
      beneficiaryId: 'b1',
      amount: 50.0,
      allBeneficiaries: [tBeneficiary],
      monthlyTransactions: [],
    );
    registerFallbackValue(const NoParams());
    registerFallbackValue(tParams);
  });

  tearDown(() => cubit.close());

  group('TransactionCubit', () {
    // 5.5a
    test('emits [Loading, Loaded] on successful fetchTransactions()', () async {
      when(() => mockGetUseCase(any())).thenAnswer((_) async => Right(tList));

      expectLater(
        cubit.stream,
        emitsInOrder([isA<TransactionLoading>(), isA<TransactionLoaded>()]),
      );

      await cubit.fetchTransactions();
    });

    // 5.5b
    test('emits [Loading, TopUpSuccess, TransactionLoaded] on successful topUp()', () async {
      when(() => mockTopUpUseCase(any())).thenAnswer((_) async => Right(tTransaction));

      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<TransactionLoading>(),
          isA<TopUpSuccess>(),
          isA<TransactionLoaded>(),
        ]),
      );

      await cubit.topUp(tParams);
    });

    // 5.5c
    test('emits [Loading, Error] on failed topUp()', () async {
      when(() => mockTopUpUseCase(any()))
          .thenAnswer((_) async => const Left(ValidationFailure('Insufficient balance.')));

      expectLater(
        cubit.stream,
        emitsInOrder([isA<TransactionLoading>(), isA<TransactionError>()]),
      );

      await cubit.topUp(tParams);
    });
  });
}
