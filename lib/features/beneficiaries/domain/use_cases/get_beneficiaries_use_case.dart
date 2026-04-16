import 'package:dartz/dartz.dart';
import 'package:top_up_app/core/errors/failure.dart';
import 'package:top_up_app/core/services/use_cases/base_use_case.dart';
import 'package:top_up_app/features/beneficiaries/domain/entities/beneficiary_entity.dart';
import 'package:top_up_app/features/beneficiaries/domain/repo/i_beneficiary_repository.dart';

class GetBeneficiariesUseCase
    extends BaseUseCase<List<BeneficiaryEntity>, NoParams> {
  final IBeneficiaryRepository repository;

  GetBeneficiariesUseCase(this.repository);

  @override
  Future<Either<Failure, List<BeneficiaryEntity>>> call(NoParams params) async {
    return await repository.getBeneficiaries();
  }
}
