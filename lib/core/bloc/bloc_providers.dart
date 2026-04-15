import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/services/service_locator/di.dart';

import 'theme_cubit/theme_cubit.dart';

final providers = [
  BlocProvider<ThemeCubit>(create: (context) => sl<ThemeCubit>()),
];
