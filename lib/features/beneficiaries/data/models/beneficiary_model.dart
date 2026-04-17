class BeneficiaryModel {
  final String id;
  final String nickname;
  final String phoneNumber;

  const BeneficiaryModel({
    required this.id,
    required this.nickname,
    required this.phoneNumber,
  });

  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) {
    return BeneficiaryModel(
      id: json['id'] as String,
      nickname: json['nickname'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nickname': nickname, 'phoneNumber': phoneNumber};
  }
}
