import 'package:top_up_app/features/profile/_profile.dart';

class UserMapper {
  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      id: model.id,
      name: model.name,
      balance: model.balance,
      isVerified: model.isVerified,
    );
  }
}
