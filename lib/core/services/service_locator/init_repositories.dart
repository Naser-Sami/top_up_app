import 'package:top_up_app/features/profile/data/data.dart';
import 'package:top_up_app/features/profile/domain/repo/i_user_repository.dart';

import 'di.dart';

void initRepositories() {
  _profile();
}

void _profile() {
  sl.registerLazySingleton<IUserRepository>(
    () => UserRepositoryImpl(sl<UserRemoteDataSource>()),
  );
}
