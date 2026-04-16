import 'package:dartz/dartz.dart';
import 'package:top_up_app/core/errors/failure.dart';
import 'package:top_up_app/core/services/use_cases/base_use_case.dart';
import 'package:top_up_app/features/beneficiaries/domain/entities/beneficiary_entity.dart';
import 'package:top_up_app/features/beneficiaries/domain/params/add_beneficiary_params.dart';
import 'package:top_up_app/features/beneficiaries/domain/repo/i_beneficiary_repository.dart';

class AddBeneficiaryUseCase
    extends BaseUseCase<BeneficiaryEntity, AddBeneficiaryParams> {
  final IBeneficiaryRepository repository;

  AddBeneficiaryUseCase(this.repository);

  @override
  Future<Either<Failure, BeneficiaryEntity>> call(
    AddBeneficiaryParams params,
  ) async {
    final nickname = params.nickname.trim();

    if (nickname.isEmpty || nickname.length > 20) {
      return const Left(
        ValidationFailure('Nickname must be between 1 and 20 characters.'),
      );
    }

    // Check if the user has already reached the maximum number of beneficiaries.
    final currentBeneficiariesResult = await repository.getBeneficiaries();

    return currentBeneficiariesResult.fold(
      (failure) {
        return Left(failure);
      },
      (beneficiaries) async {
        if (beneficiaries.length >= 5) {
          return const Left(
            ValidationFailure('Maximum of 5 active beneficiaries allowed.'),
          );
        }

        // All business rules passed! We are safe to add it to the repository.
        return await repository.addBeneficiary(params);
      },
    );
  }
}
