import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final double balance;
  final bool isVerified;

  const UserModel({
    required this.id,
    required this.name,
    required this.balance,
    required this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      balance: (json['balance'] as num).toDouble(),
      isVerified: json['isVerified'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
      'isVerified': isVerified,
    };
  }

  @override
  List<Object?> get props => [id, name, balance, isVerified];
}
