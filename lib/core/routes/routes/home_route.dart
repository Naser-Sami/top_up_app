import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_up_app/core/routes/app_route.dart';
import 'package:top_up_app/features/home/_home.dart';

class HomeRoute extends AppRoute {
  static const String path = '/';
  static const String name = 'home';

  @override
  Widget pageBuilder(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}
