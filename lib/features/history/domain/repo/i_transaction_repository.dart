import 'package:dartz/dartz.dart';
import 'package:top_up_app/core/errors/failure.dart';
import 'package:top_up_app/features/history/domain/entities/_entities.dart';
import 'package:top_up_app/features/history/domain/params/_params.dart';

abstract class ITransactionRepository {
  Future<Either<Failure, List<TransactionEntity>>> getTransactions();
  Future<Either<Failure, TransactionEntity>> topUp(TopUpParams params);
}
