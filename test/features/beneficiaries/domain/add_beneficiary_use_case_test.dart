import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_up_app/core/errors/failure.dart';
import 'package:top_up_app/features/beneficiaries/domain/entities/beneficiary_entity.dart';
import 'package:top_up_app/features/beneficiaries/domain/params/add_beneficiary_params.dart';
import 'package:top_up_app/features/beneficiaries/domain/repo/i_beneficiary_repository.dart';
import 'package:top_up_app/features/beneficiaries/domain/use_cases/add_beneficiary_use_case.dart';

class MockIBeneficiaryRepository extends Mock implements IBeneficiaryRepository {}

void main() {
  late MockIBeneficiaryRepository mockRepo;
  late AddBeneficiaryUseCase useCase;

  // Shared fixtures
  final tBeneficiary = BeneficiaryEntity(id: 'b1', nickname: 'Alice', phoneNumber: '+971501234567');
  final tValidParams = AddBeneficiaryParams(nickname: 'Alice', phoneNumber: '+971501234567');
  final tFiveBeneficiaries = List.generate(5, (i) =>
      BeneficiaryEntity(id: 'b$i', nickname: 'Name$i', phoneNumber: '+9715000000$i'));

  setUp(() {
    mockRepo = MockIBeneficiaryRepository();
    useCase = AddBeneficiaryUseCase(mockRepo);
    registerFallbackValue(tValidParams);
  });

  group('AddBeneficiaryUseCase', () {
    // 5.1a
    test('returns Left(Failure) when beneficiary count is already 5 (BR-01)', () async {
      when(() => mockRepo.getBeneficiaries())
          .thenAnswer((_) async => Right(tFiveBeneficiaries));

      final result = await useCase(tValidParams);

      expect(result.isLeft(), true);
      verifyNever(() => mockRepo.addBeneficiary(any()));
    });

    // 5.1b
    test('returns Left(Failure) when nickname is empty (BR-02)', () async {
      final params = AddBeneficiaryParams(nickname: '', phoneNumber: '+971501234567');

      final result = await useCase(params);

      expect(result.isLeft(), true);
      verifyNever(() => mockRepo.getBeneficiaries());
      verifyNever(() => mockRepo.addBeneficiary(any()));
    });

    // 5.1c
    test('returns Left(Failure) when nickname exceeds 20 characters (BR-02)', () async {
      final params = AddBeneficiaryParams(nickname: 'A' * 21, phoneNumber: '+971501234567');

      final result = await useCase(params);

      expect(result.isLeft(), true);
      verifyNever(() => mockRepo.getBeneficiaries());
      verifyNever(() => mockRepo.addBeneficiary(any()));
    });

    // 5.1d
    test('returns Right(BeneficiaryEntity) on valid input with fewer than 5 beneficiaries', () async {
      when(() => mockRepo.getBeneficiaries())
          .thenAnswer((_) async => const Right([]));
      when(() => mockRepo.addBeneficiary(any()))
          .thenAnswer((_) async => Right(tBeneficiary));

      final result = await useCase(tValidParams);

      expect(result, Right(tBeneficiary));
    });
  });
}
