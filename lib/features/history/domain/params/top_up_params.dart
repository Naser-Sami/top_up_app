import 'package:equatable/equatable.dart';
import 'package:top_up_app/features/beneficiaries/domain/domain.dart';
import 'package:top_up_app/features/history/domain/domain.dart';
import 'package:top_up_app/features/profile/domain/domain.dart';

class TopUpParams extends Equatable {
  final UserEntity user;
  final String beneficiaryId;
  final double amount;

  // TODO: If we do not use allBeneficiaries later, we can remove it.
  final List<BeneficiaryEntity> allBeneficiaries;
  final List<TransactionEntity> monthlyTransactions;

  const TopUpParams({
    required this.user,
    required this.beneficiaryId,
    required this.amount,
    required this.allBeneficiaries,
    required this.monthlyTransactions,
  });

  @override
  List<Object?> get props => [
    user,
    beneficiaryId,
    amount,
    allBeneficiaries,
    monthlyTransactions,
  ];
}
