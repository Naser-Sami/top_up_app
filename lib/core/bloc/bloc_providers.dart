import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/services/service_locator/di.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';
import 'package:top_up_app/features/history/_history.dart';
import 'package:top_up_app/features/profile/presentation/controllers/user_cubit/user_cubit.dart';

import 'theme_cubit/theme_cubit.dart';

final providers = [
  BlocProvider<ThemeCubit>(create: (context) => sl<ThemeCubit>()),
  BlocProvider<UserCubit>(create: (context) => sl<UserCubit>()),
  BlocProvider<BeneficiaryCubit>(create: (context) => sl<BeneficiaryCubit>()),
  BlocProvider<TransactionCubit>(create: (context) => sl<TransactionCubit>()),
];
