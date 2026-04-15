import 'package:equatable/equatable.dart';

class BeneficiaryEntity extends Equatable {
  final String id;
  final String nickname;
  final String phoneNumber;

  const BeneficiaryEntity({
    required this.id,
    required this.nickname,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [id, nickname, phoneNumber];
}
