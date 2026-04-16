
import 'package:dartz/dartz.dart';
import 'package:top_up_app/core/errors/failure.dart';
import 'package:top_up_app/features/beneficiaries/domain/entities/beneficiary_entity.dart';
import 'package:top_up_app/features/beneficiaries/domain/params/add_beneficiary_params.dart';

abstract class IBeneficiaryRepository {
  Future<Either<Failure, List<BeneficiaryEntity>>> getBeneficiaries();
  Future<Either<Failure, BeneficiaryEntity>> addBeneficiary(AddBeneficiaryParams params);
}