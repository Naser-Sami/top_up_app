import 'package:top_up_app/features/beneficiaries/domain/repo/i_beneficiary_repository.dart';
import 'package:top_up_app/features/beneficiaries/domain/use_cases/add_beneficiary_use_case.dart';
import 'package:top_up_app/features/beneficiaries/domain/use_cases/get_beneficiaries_use_case.dart';
import 'package:top_up_app/features/history/domain/repo/i_transaction_repository.dart';
import 'package:top_up_app/features/history/domain/use_cases/get_transactions_use_case.dart';
import 'package:top_up_app/features/history/domain/use_cases/top_up_use_case.dart';
import 'package:top_up_app/features/profile/_profile.dart';

import 'di.dart';

void initUseCases() {
  _profile();
  _beneficiaries();
  _transactions();
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

void _transactions() {
  sl.registerFactory<GetTransactionsUseCase>(
    () => GetTransactionsUseCase(sl<ITransactionRepository>()),
  );
  sl.registerFactory<TopUpUseCase>(
    () => TopUpUseCase(sl<ITransactionRepository>()),
  );
}
