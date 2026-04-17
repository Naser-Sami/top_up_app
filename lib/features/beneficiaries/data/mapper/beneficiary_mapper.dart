import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';
import 'package:top_up_app/features/beneficiaries/data/models/beneficiary_model.dart';

class BeneficiaryMapper {
  static BeneficiaryEntity toEntity(BeneficiaryModel model) {
    return BeneficiaryEntity(
      id: model.id,
      nickname: model.nickname,
      phoneNumber: model.phoneNumber,
    );
  }
}
