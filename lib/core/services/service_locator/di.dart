import 'package:get_it/get_it.dart';

import 'init_data_sources.dart';
import 'init_repositories.dart';
import 'init_use_cases.dart';
import 'init_controllers.dart';

final sl = GetIt.I;

class DI {
  Future<void> init() async {
    initDataSources();
    initRepositories();
    initUseCases();
    initControllers();
  }
}
