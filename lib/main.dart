import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/bloc/bloc_providers.dart';
import 'core/services/initializer/initializer.dart';

Future<void> main() async {
  Initializer initializer = Initializer();
  await initializer.init();

  runApp(MultiBlocProvider(providers: providers, child: const MyApp()));
}
