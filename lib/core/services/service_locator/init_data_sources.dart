import 'package:top_up_app/features/profile/data/data.dart';

import 'di.dart';

void initDataSources() {
  _profile();
}

void _profile() {
  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSource());
}
