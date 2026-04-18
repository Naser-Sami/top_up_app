import 'package:dartz/dartz.dart';
import 'package:top_up_app/core/errors/failure.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';
import 'package:top_up_app/features/beneficiaries/data/mapper/beneficiary_mapper.dart';
import 'package:top_up_app/features/beneficiaries/domain/repo/i_beneficiary_repository.dart';

class BeneficiaryRepositoryImpl implements IBeneficiaryRepository {
  final IBeneficiaryRemoteDataSource _beneficiaryRemoteDataSource;

  const BeneficiaryRepositoryImpl(this._beneficiaryRemoteDataSource);

  @override
  Future<Either<Failure, BeneficiaryEntity>> addBeneficiary(
    AddBeneficiaryParams params,
  ) async {
    try {
      final beneficiaryModel = await _beneficiaryRemoteDataSource
          .addBeneficiary(params);
      final beneficiaryEntity = BeneficiaryMapper.toEntity(beneficiaryModel);
      return Right(beneficiaryEntity);
    } catch (e) {
      return const Left(ServerFailure('Failed to add beneficiary.'));
    }
  }

  @override
  Future<Either<Failure, List<BeneficiaryEntity>>> getBeneficiaries() async {
    try {
      final beneficiaryModels = await _beneficiaryRemoteDataSource
          .getBeneficiaries();
      final beneficiaryEntities = beneficiaryModels
          .map((model) => BeneficiaryMapper.toEntity(model))
          .toList();
      return Right(beneficiaryEntities);
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch beneficiaries.'));
    }
  }
}
