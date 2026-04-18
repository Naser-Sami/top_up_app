import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  final String id;
  final String beneficiaryId;
  final double amount;
  final double fee;
  final DateTime createdAt;

  const TransactionModel({
    required this.id,
    required this.beneficiaryId,
    required this.amount,
    required this.fee,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      beneficiaryId: json['beneficiaryId'] as String,
      amount: (json['amount'] as num).toDouble(),
      fee: (json['fee'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'beneficiaryId': beneficiaryId,
      'amount': amount,
      'fee': fee,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, beneficiaryId, amount, fee, createdAt];
}
