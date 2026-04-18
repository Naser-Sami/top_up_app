import 'package:top_up_app/features/beneficiaries/data/data.dart';
import 'package:top_up_app/features/history/_history.dart';
import 'package:top_up_app/features/profile/data/data.dart';

import 'di.dart';

void initDataSources() {
  _profile();
  _beneficiaries();
  _transactions();
}

void _profile() {
  sl.registerLazySingleton<IUserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );
}

void _beneficiaries() {
  sl.registerLazySingleton<IBeneficiaryRemoteDataSource>(
    () => BeneficiaryRemoteDataSourceImpl(),
  );
}

void _transactions() {
  sl.registerLazySingleton<ITransactionRemoteDataSource>(
    () => TransactionRemoteDataSourceImpl(),
  );
}
