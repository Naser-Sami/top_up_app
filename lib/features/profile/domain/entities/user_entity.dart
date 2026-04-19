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

  const UserEntity.empty()
    : this(id: '', name: '', balance: 0, isVerified: false);

  UserEntity copyWith({
    String? id,
    String? name,
    double? balance,
    bool? isVerified,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  @override
  List<Object?> get props => [id, name, balance, isVerified];
}
