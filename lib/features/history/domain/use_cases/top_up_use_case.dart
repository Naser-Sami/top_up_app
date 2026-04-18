import 'package:dartz/dartz.dart';
import 'package:top_up_app/core/constants/top_up_option.dart';
import 'package:top_up_app/core/errors/failure.dart';
import 'package:top_up_app/core/services/use_cases/base_use_case.dart';
import 'package:top_up_app/features/history/domain/domain.dart';

class TopUpUseCase extends BaseUseCase<TransactionEntity, TopUpParams> {
  final ITransactionRepository repository;

  TopUpUseCase(this.repository);

  @override
  Future<Either<Failure, TransactionEntity>> call(TopUpParams params) async {
    final fee = TopUpOption.transactionFee; 
    final options = TopUpOption.validOptions;

    // 1. Enforce Valid Top-Up Amount
    if (!options.contains(params.amount)) {
      return const Left(ValidationFailure('Invalid top-up amount.'));
    }

    // 2. Enforce Balance Check
    final totalCost = params.amount + fee;
    if (params.user.balance < totalCost) {
      return const Left(ValidationFailure('Insufficient balance.'));
    }

    // Calculate spends from history
    double spendForThisBeneficiary = 0.0;
    double globalSpendAllBeneficiaries = 0.0;

    for (final transaction in params.monthlyTransactions) {
      globalSpendAllBeneficiaries += transaction.amount;
      
      if (transaction.beneficiaryId == params.beneficiaryId) {
        spendForThisBeneficiary += transaction.amount;
      }
    }

    // 3. Enforce Beneficiary Monthly Limits
    final beneficiaryLimit = params.user.isVerified ? 1000.0 : 500.0;
    if (spendForThisBeneficiary + params.amount > beneficiaryLimit) {
    return const Left(ValidationFailure(
        'Monthly top-up limit reached for this specific beneficiary.'
      ));
    }

    // 4. Enforce Global Monthly Limit
    const globalLimit = 3000.0;
    if (globalSpendAllBeneficiaries + params.amount > globalLimit) {
      return const Left(ValidationFailure(
        'Total global monthly top-up limit of AED 3,000 reached.'
      ));
    }

    // All business rules passed! Safely execute the transaction.
    return await repository.topUp(params);
  }
}