import 'package:top_up_app/core/constants/top_up_option.dart';
import 'package:top_up_app/features/history/_history.dart';

abstract class ITransactionRemoteDataSource {
  Future<List<TransactionModel>> getTransactions();
}

class TransactionRemoteDataSourceImpl implements ITransactionRemoteDataSource {
  @override
  Future<List<TransactionModel>> getTransactions() async {
    await Future.delayed(const Duration(seconds: 1));

    final now = DateTime.now();
    final fee = TopUpOption.transactionFee;

    return [
      TransactionModel(
        id: 'txn_1',
        beneficiaryId: 'ben_1',
        amount: 400.0,
        fee: fee,
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      TransactionModel(
        id: 'txn_2',
        beneficiaryId: 'ben_2',
        amount: 800.0,
        fee: fee,
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      TransactionModel(
        id: 'txn_3',
        beneficiaryId: 'ben_3',
        amount: 1200.0,
        fee: fee,
        createdAt: now.subtract(const Duration(days: 5)),
      ),
    ];
  }
}
