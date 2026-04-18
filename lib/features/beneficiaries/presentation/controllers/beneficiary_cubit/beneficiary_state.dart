import 'package:equatable/equatable.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';

abstract class BeneficiaryState extends Equatable {
  const BeneficiaryState();

  @override
  List<Object?> get props => [];
}

class BeneficiaryInitial extends BeneficiaryState with EquatableMixin{
  const BeneficiaryInitial();
  @override
  List<Object?> get props => [];
}

class BeneficiaryLoading extends BeneficiaryState with EquatableMixin {
  const BeneficiaryLoading();

  @override
  List<Object?> get props => [];
}

class BeneficiaryLoaded extends BeneficiaryState with EquatableMixin{
  final List<BeneficiaryEntity> beneficiaries;
  const BeneficiaryLoaded(this.beneficiaries);

  @override
  List<Object?> get props => [beneficiaries];
}

class BeneficiaryAdded extends BeneficiaryState with EquatableMixin{
  const BeneficiaryAdded();

  @override
  List<Object?> get props => [];
}

class BeneficiaryError extends BeneficiaryState with EquatableMixin{
  final String message;
  const BeneficiaryError(this.message);

  @override
  List<Object?> get props => [message];
}