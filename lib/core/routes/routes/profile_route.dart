import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_up_app/core/routes/app_route.dart';
import 'package:top_up_app/features/profile/_profile.dart';

class ProfileRoute extends AppRoute {
  static const String path = '/profile';
  static const String name = 'profile';

  @override
  Widget pageBuilder(BuildContext context, GoRouterState state) {
    return const ProfileScreen();
  }
}
