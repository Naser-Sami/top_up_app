import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_up_app/core/errors/failure.dart';
import 'package:top_up_app/features/beneficiaries/domain/entities/beneficiary_entity.dart';
import 'package:top_up_app/features/history/domain/entities/transaction_entity.dart';
import 'package:top_up_app/features/history/domain/params/top_up_params.dart';
import 'package:top_up_app/features/history/domain/repo/i_transaction_repository.dart';
import 'package:top_up_app/features/history/domain/use_cases/top_up_use_case.dart';
import 'package:top_up_app/features/profile/domain/entities/user_entity.dart';

class MockITransactionRepository extends Mock implements ITransactionRepository {}

void main() {
  late MockITransactionRepository mockRepo;
  late TopUpUseCase useCase;

  final tVerifiedUser = UserEntity(id: 'u1', name: 'Ahmed', balance: 2000.0, isVerified: true);
  final tUnverifiedUser = UserEntity(id: 'u1', name: 'Ahmed', balance: 2000.0, isVerified: false);
  final tBeneficiary = BeneficiaryEntity(id: 'b1', nickname: 'Alice', phoneNumber: '+971501234567');
  final now = DateTime.now();

  TransactionEntity makeTransaction(String beneficiaryId, double amount) =>
      TransactionEntity(id: 'tx1', beneficiaryId: beneficiaryId, amount: amount, fee: 3.0, createdAt: now);

  TopUpParams makeParams({
    required UserEntity user,
    double amount = 50.0,
    String beneficiaryId = 'b1',
    List<TransactionEntity> monthlyTransactions = const [],
  }) =>
      TopUpParams(
        user: user,
        beneficiaryId: beneficiaryId,
        amount: amount,
        allBeneficiaries: [tBeneficiary],
        monthlyTransactions: monthlyTransactions,
      );

  setUp(() {
    mockRepo = MockITransactionRepository();
    useCase = TopUpUseCase(mockRepo);
    registerFallbackValue(makeParams(user: tVerifiedUser));
  });

  group('TopUpUseCase', () {
    // 5.2a
    test('returns Left(Failure) when amount is not in valid options (BR-03)', () async {
      final result = await useCase(makeParams(user: tVerifiedUser, amount: 15.0));
      expect(result.isLeft(), true);
      verifyNever(() => mockRepo.topUp(any()));
    });

    // 5.2b
    test('returns Left(Failure) when balance < amount + 3 (BR-05)', () async {
      final poorUser = UserEntity(id: 'u1', name: 'Ahmed', balance: 10.0, isVerified: true);
      final result = await useCase(makeParams(user: poorUser, amount: 50.0)); // needs 53, has 10
      expect(result.isLeft(), true);
      verifyNever(() => mockRepo.topUp(any()));
    });

    // 5.2c
    test('returns Left(Failure) when unverified user monthly spend would exceed AED 500 (BR-06)', () async {
      final existingSpend = [makeTransaction('b1', 480.0)]; // 480 spent, adding 50 = 530 > 500
      final result = await useCase(makeParams(user: tUnverifiedUser, amount: 50.0, monthlyTransactions: existingSpend));
      expect(result.isLeft(), true);
      verifyNever(() => mockRepo.topUp(any()));
    });

    // 5.2d
    test('returns Left(Failure) when verified user monthly spend would exceed AED 1000 (BR-07)', () async {
      final existingSpend = [makeTransaction('b1', 980.0)]; // 980 spent, adding 50 = 1030 > 1000
      final result = await useCase(makeParams(user: tVerifiedUser, amount: 50.0, monthlyTransactions: existingSpend));
      expect(result.isLeft(), true);
      verifyNever(() => mockRepo.topUp(any()));
    });

    // 5.2e
    test('returns Left(Failure) when total monthly spend across all beneficiaries would exceed AED 3000 (BR-08)', () async {
      // Global spend near limit — use two beneficiaries totalling 2980
      final existingSpend = [
        makeTransaction('b1', 1000.0),
        makeTransaction('b2', 1980.0),
      ];
      // tVerifiedUser: b1 limit=1000, b1 spent=1000 — would fail BR-07 first.
      // Use b3 (different from b1 and b2) so BR-06/07 passes, only BR-08 fires.
      final result = await useCase(makeParams(
        user: tVerifiedUser,
        amount: 50.0,
        beneficiaryId: 'b3',
        monthlyTransactions: existingSpend, // global=2980, +50=3030 > 3000
      ));
      expect(result.isLeft(), true);
      verifyNever(() => mockRepo.topUp(any()));
    });

    // 5.2f
    test('returns Right(TransactionEntity) with fee=3 on a fully valid transaction (BR-04)', () async {
      final tTransaction = makeTransaction('b1', 50.0);
      when(() => mockRepo.topUp(any())).thenAnswer((_) async => Right(tTransaction));

      final result = await useCase(makeParams(user: tVerifiedUser, amount: 50.0));

      expect(result.isRight(), true);
      result.fold((_) {}, (tx) => expect(tx.fee, 3.0));
    });

    // 5.2g — BR-10: balance failure reported before monthly-limit failure
    test('reports balance failure before monthly-limit failure when both conditions fail (BR-10)', () async {
      final brokeUser = UserEntity(id: 'u1', name: 'Ahmed', balance: 2.0, isVerified: true);
      final existingSpend = [makeTransaction('b1', 980.0)]; // would also exceed limit
      // balance=2 < 53, AND monthly would exceed 1000 — BR-05 must fire first
      final result = await useCase(makeParams(user: brokeUser, amount: 50.0, monthlyTransactions: existingSpend));
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure.message, contains('balance')), // message says 'Insufficient balance'
        (_) => fail('Expected Left'),
      );
      verifyNever(() => mockRepo.topUp(any()));
    });
  });
}
