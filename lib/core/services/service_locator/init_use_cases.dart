import 'package:top_up_app/features/beneficiaries/domain/repo/i_beneficiary_repository.dart';
import 'package:top_up_app/features/beneficiaries/domain/use_cases/add_beneficiary_use_case.dart';
import 'package:top_up_app/features/beneficiaries/domain/use_cases/get_beneficiaries_use_case.dart';
import 'package:top_up_app/features/profile/_profile.dart';

import 'di.dart';

void initUseCases() {
  _profile();
  _beneficiaries();
}

void _profile() {
  sl.registerFactory<GetUserUseCase>(
    () => GetUserUseCase(sl<IUserRepository>()),
  );
}

void _beneficiaries() {
  sl.registerFactory<AddBeneficiaryUseCase>(
    () => AddBeneficiaryUseCase(sl<IBeneficiaryRepository>()),
  );
  sl.registerFactory<GetBeneficiariesUseCase>(
    () => GetBeneficiariesUseCase(sl<IBeneficiaryRepository>()),
  );
}
