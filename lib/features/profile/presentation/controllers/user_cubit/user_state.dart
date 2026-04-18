import 'package:equatable/equatable.dart';
import 'package:top_up_app/features/profile/domain/domain.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState with EquatableMixin {
  const UserInitial();

  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState with EquatableMixin{
  const UserLoading();

  @override
  List<Object?> get props => [];
}

class UserLoaded extends UserState with EquatableMixin{
  final UserEntity user;
  const UserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class UserError extends UserState with EquatableMixin{
  final String message;
  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
