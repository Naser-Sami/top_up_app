import 'package:top_up_app/core/bloc/theme_cubit/theme_cubit.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';
import 'package:top_up_app/features/history/_history.dart';
import 'package:top_up_app/features/profile/domain/use_cases/_use_cases.dart';
import 'package:top_up_app/features/profile/presentation/controllers/_controllers.dart';

import 'di.dart';

void initControllers() {
  _theme();
  _profile();
  _beneficiaries();
  _transactions();
}

void _theme() {
  sl.registerFactory<ThemeCubit>(ThemeCubit.new);
}

void _profile() {
  sl.registerFactory<UserCubit>(
    () => UserCubit(getUserUseCase: sl<GetUserUseCase>()),
  );
}

void _beneficiaries() {
  sl.registerFactory<BeneficiaryCubit>(
    () => BeneficiaryCubit(
      addBeneficiaryUseCase: sl<AddBeneficiaryUseCase>(),
      getBeneficiariesUseCase: sl<GetBeneficiariesUseCase>(),
    ),
  );
}

void _transactions() {
  sl.registerFactory<TransactionCubit>(
    () => TransactionCubit(
      getTransactionsUseCase: sl<GetTransactionsUseCase>(),
      topUpUseCase: sl<TopUpUseCase>(),
    ),
  );
}
