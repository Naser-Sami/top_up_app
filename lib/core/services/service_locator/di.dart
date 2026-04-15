import 'package:get_it/get_it.dart';

import 'init_controllers.dart';

final sl = GetIt.I;

class DI {
  Future<void> init() async {
    initControllers();
  }
}
