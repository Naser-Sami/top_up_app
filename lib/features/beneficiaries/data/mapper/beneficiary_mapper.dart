import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';

class BeneficiaryMapper {
  static BeneficiaryEntity toEntity(BeneficiaryModel model) {
    return BeneficiaryEntity(
      id: model.id,
      nickname: model.nickname,
      phoneNumber: model.phoneNumber,
    );
  }
}
