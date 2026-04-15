import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:top_up_app/core/services/service_locator/di.dart';

class Initializer {
  Initializer._();

  static final Initializer _instance = Initializer._();
  factory Initializer() => _instance;

  WidgetsBinding get widgetsBinding =>
      WidgetsFlutterBinding.ensureInitialized();

  Future<void> init() async {
    widgetsBinding;
    await Future.wait([initServiceLocator(), initHydratedBloc()]);
  }

  Future<void> initServiceLocator() async {
    await DI().init();
  }

  Future<void> initHydratedBloc() async {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorageDirectory.web
          : HydratedStorageDirectory((await getTemporaryDirectory()).path),
    );
  }
}
