import 'package:equatable/equatable.dart';
import 'package:top_up_app/features/history/_history.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState with EquatableMixin {
  const TransactionInitial();

  @override
  List<Object?> get props => [];
}

class TransactionLoading extends TransactionState with EquatableMixin {
  const TransactionLoading();

  @override
  List<Object?> get props => [];
}

class TransactionLoaded extends TransactionState with EquatableMixin {
  final List<TransactionEntity> transactions;
  const TransactionLoaded(this.transactions);

  @override
  List<Object?> get props => [transactions];
}

class TopUpSuccess extends TransactionState with EquatableMixin {
  final TransactionEntity transaction;
  const TopUpSuccess(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class TransactionError extends TransactionState with EquatableMixin {
  final String message;
  const TransactionError(this.message);

  @override
  List<Object?> get props => [message];
}
