import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_up_app/core/routes/app_route.dart';
import 'package:top_up_app/features/history/_history.dart';

class HistoryRoute extends AppRoute {
  static const String path = '/history';
  static const String name = 'history';

  @override
  Widget pageBuilder(BuildContext context, GoRouterState state) {
    return HistoryScreen();
  }
}
