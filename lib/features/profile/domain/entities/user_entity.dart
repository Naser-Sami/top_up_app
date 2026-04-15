import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final double balance;
  final bool isVerified;

  const UserEntity({
    required this.id,
    required this.name,
    required this.balance,
    required this.isVerified,
  });

  @override
  List<Object?> get props => [id, name, balance, isVerified];
}
