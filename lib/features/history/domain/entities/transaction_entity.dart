
import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String id;
  final String beneficiaryId;
  final double amount;
  final double fee;
  final DateTime createdAt;

  const TransactionEntity({
    required this.id,
    required this.beneficiaryId,
    required this.amount,
    required this.fee,
    required this.createdAt,
  });
  
  @override
  List<Object?> get props => [id, beneficiaryId, amount, fee, createdAt];
}