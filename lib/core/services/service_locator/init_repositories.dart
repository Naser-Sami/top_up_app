import 'package:top_up_app/features/beneficiaries/data/data.dart';
import 'package:top_up_app/features/beneficiaries/data/repo_impl/beneficiary_repository_impl.dart';
import 'package:top_up_app/features/beneficiaries/domain/repo/i_beneficiary_repository.dart';
import 'package:top_up_app/features/history/_history.dart';
import 'package:top_up_app/features/history/domain/repo/i_transaction_repository.dart';
import 'package:top_up_app/features/profile/data/data.dart';
import 'package:top_up_app/features/profile/domain/repo/i_user_repository.dart';

import 'di.dart';

void initRepositories() {
  _profile();
  _beneficiaries();
  _transactions();
}

void _profile() {
  sl.registerLazySingleton<IUserRepository>(
    () => UserRepositoryImpl(sl<IUserRemoteDataSource>()),
  );
}

void _beneficiaries() {
  sl.registerLazySingleton<IBeneficiaryRepository>(
    () => BeneficiaryRepositoryImpl(sl<IBeneficiaryRemoteDataSource>()),
  );
}

void _transactions() {
  sl.registerLazySingleton<ITransactionRepository>(
    () => TransactionRepositoryImpl(sl<ITransactionRemoteDataSource>()),
  );
}
