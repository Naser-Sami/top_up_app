import 'package:top_up_app/core/bloc/theme_cubit/theme_cubit.dart';

import 'di.dart';

void initControllers() {
  _theme();
}

void _theme() {
  sl.registerFactory<ThemeCubit>(ThemeCubit.new);
}
