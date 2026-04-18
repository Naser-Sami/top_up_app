import 'package:dartz/dartz.dart';
import 'package:top_up_app/core/errors/failure.dart';
import 'package:top_up_app/core/services/use_cases/base_use_case.dart';
import 'package:top_up_app/features/history/domain/domain.dart';

class GetTransactionsUseCase
    extends BaseUseCase<List<TransactionEntity>, NoParams> {
  final ITransactionRepository repository;
  GetTransactionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<TransactionEntity>>> call(NoParams params) async {
    return await repository.getTransactions();
  }
}
