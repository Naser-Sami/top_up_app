import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The base class of page's routes.
///
/// Every page you need to navigate to it needs a route class that:
/// - facilitates dealing with route's path params, query params and extra object.
/// - Keeps the router file clean and has no logic. Only route's declarations or general config.
/// - Makes sure that the route's logic of path params, query params and extra object is written once and usable for each navigation operation.
///   *** PLEASE add [queryParamsBuilder], [pathParamsBuilder] and [extraBuilder] static methods as needed. and Don't pass pure maps explicitly in navigation.
/// - Reduces the boilerplate code of creating go routes.
/// - No more maps and static keys outside the route which means more Type-safe navigation.
abstract class AppRoute {
  /// The entrypoint of the route which create the [GoRoute] to add it inside the router's routes.
  GoRoute create({
    required String path,
    String? name,
    GlobalKey<NavigatorState>? parentNavigatorKey,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      parentNavigatorKey: parentNavigatorKey,
      path: path,
      name: name,
      pageBuilder: (context, state) {
        // Check if route has custom transition
        final customTransition = buildCustomTransition(context, state);
        if (customTransition != null) {
          return customTransition;
        }
        // Use default page transition
        return defaultPage(
          child: pageBuilder(context, state),
          pageKey: state.pageKey,
        );
      },
      redirect: redirect,
      routes: routes,
    );
  }

  /// Responsible of building destination page.
  /// handle and parse the passed params inside it.
  Widget pageBuilder(BuildContext context, GoRouterState state);

  /// The default page used as wrapper for [pageBuilder].
  /// override this method in order to create a new page experience.
  /// eg: creating custom transition.
  Page<dynamic> defaultPage({required Widget child, LocalKey? pageKey}) {
    return MaterialPage(child: child);
  }

  /// Override this method to provide custom page transitions.
  /// Return null to use the default transition (MaterialPage).
  ///
  /// Example:
  /// ```dart
  /// @override
  /// CustomTransitionPage? buildCustomTransition(
  ///   BuildContext context,
  ///   GoRouterState state,
  /// ) {
  ///   return CustomTransitionPage(
  ///     key: state.pageKey,
  ///     child: pageBuilder(context, state),
  ///     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  ///       return FadeTransition(opacity: animation, child: child);
  ///     },
  ///   );
  /// }
  /// ```
  CustomTransitionPage? buildCustomTransition(
    BuildContext context,
    GoRouterState state,
  ) {
    return null; // Default: no custom transition
  }

  /// Responsible of redirection logic
  /// Implement it once your route needs guard.
  /// eg: user can't navigates to notification page unless he/she authenticated so notification route should implement [redirect] method.
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    return null;
  }
}
