import 'package:dartz/dartz.dart';
import 'package:top_up_app/core/constants/top_up_option.dart';
import 'package:top_up_app/core/errors/failure.dart';
import 'package:top_up_app/features/history/_history.dart';

class TransactionRepositoryImpl implements ITransactionRepository {
  final ITransactionRemoteDataSource _transactionRemoteDataSource;

  const TransactionRepositoryImpl(this._transactionRemoteDataSource);

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactions() async {
    try {
      final transactionModel = await _transactionRemoteDataSource
          .getTransactions();
      final transactionEntity = transactionModel
          .map((TransactionMapper.toEntity))
          .toList();
      return Right(transactionEntity);
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch transactions data.'));
    }
  }

  @override
  Future<Either<Failure, TransactionEntity>> topUp(TopUpParams params) async {
    try {
      final fee = TopUpOption.transactionFee;

      await Future.delayed(const Duration(seconds: 1));

      final newTransaction = TransactionEntity(
        id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
        beneficiaryId: params.beneficiaryId,
        amount: params.amount,
        fee: fee,
        createdAt: DateTime.now(),
      );

      return Right(newTransaction);
    } catch (e) {
      return const Left(ServerFailure('Failed to perform top-up transaction.'));
    }
  }
}
