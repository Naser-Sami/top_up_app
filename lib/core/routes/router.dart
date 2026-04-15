import 'package:go_router/go_router.dart';
import 'package:top_up_app/core/services/navigation_service/navigation_service.dart';

import 'routes/routes.dart';

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: routes,
);
