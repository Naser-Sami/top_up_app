import 'package:top_up_app/features/profile/_profile.dart';

// The Interface (Contract)
abstract class IUserRemoteDataSource {
  Future<UserModel> fetchUser();
}

// The Implementation
class UserRemoteDataSourceImpl implements IUserRemoteDataSource {
  @override
  Future<UserModel> fetchUser() async {
    // Simulate network delay for UI loading states
    await Future.delayed(const Duration(seconds: 1));

    // Return a hardcoded UserModel
    return const UserModel(
      id: 'user_1',
      name: 'Nasr',
      balance: 3500.0, // Set high enough to test the AED 3000 global limit
      isVerified: true,
    );
  }
}
