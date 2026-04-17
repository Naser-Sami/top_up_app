import 'package:top_up_app/features/profile/_profile.dart';

class UserRemoteDataSource {
  Future<UserModel> fetchUser() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Return a hardcoded UserModel
    return UserModel(
      id: 'user123',
      name: 'John Doe',
      balance: 1500.0,
      isVerified: true,
    );
  }
}