import 'package:equatable/equatable.dart';

class AddBeneficiaryParams extends Equatable {
  final String nickname;
  final String phoneNumber;

  const AddBeneficiaryParams({
    required this.nickname,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [nickname, phoneNumber];
}
