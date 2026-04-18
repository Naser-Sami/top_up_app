import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_up_app/core/routes/app_route.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';

class BeneficiariesRoute extends AppRoute {
  static const String path = '/beneficiaries';
  static const String name = 'beneficiaries';

  @override
  Widget pageBuilder(BuildContext context, GoRouterState state) {
    return const BeneficiariesScreen();
  }
}
