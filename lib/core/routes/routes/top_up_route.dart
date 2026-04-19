import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_up_app/core/routes/app_route.dart';
import 'package:top_up_app/features/beneficiaries/domain/entities/beneficiary_entity.dart';
import 'package:top_up_app/features/beneficiaries/presentation/screen/top_up_screen.dart';

class TopUpRoute extends AppRoute {
  static const String path = 'top-up';
  static const String name = 'top-up';

  static void go(BuildContext context, BeneficiaryEntity beneficiary) {
    context.goNamed(name, extra: beneficiary);
  }

  @override
  Widget pageBuilder(BuildContext context, GoRouterState state) {
    final beneficiary = state.extra as BeneficiaryEntity;
    return TopUpScreen(beneficiary: beneficiary);
  }
}
