
import 'package:top_up_app/features/history/_history.dart';

class TransactionMapper {
  static TransactionEntity toEntity(TransactionModel model) {
    return TransactionEntity(
      id: model.id,
      beneficiaryId: model.beneficiaryId,
      amount: model.amount,
      fee: model.fee,
      createdAt: model.createdAt,
    );
  }
}