import 'package:top_up_app/features/profile/_profile.dart';

import 'di.dart';

void initUseCases() {
  _profile();
}

void _profile() {
  sl.registerFactory<GetUserUseCase>(
    () => GetUserUseCase(sl<IUserRepository>()),
  );
}
