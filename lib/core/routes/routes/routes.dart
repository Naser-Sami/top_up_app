import 'package:go_router/go_router.dart';
import 'package:top_up_app/core/widgets/navigation_shell.dart';
import 'history_route.dart';
import 'home_route.dart';
import 'beneficiaries_route.dart';
import 'top_up_route.dart';
import 'profile_route.dart';

/// Top-level route list consumed by [GoRouter].
///
/// The four main app tabs are wrapped inside a [StatefulShellRoute.indexedStack]
/// so each branch maintains its own [Navigator] — preserving scroll positions,
/// form state, etc. when the user switches tabs.
///
/// Branch order MUST match the [NavigationShell._items] list.
final List<RouteBase> routes = [
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) =>
        NavigationShell(navigationShell: navigationShell),
    branches: [
      // ── Branch 0: Home ──────────────────────────────────────────────────
      StatefulShellBranch(
        routes: [
          HomeRoute().create(path: HomeRoute.path, name: HomeRoute.name),
        ],
      ),

      // ── Branch 1: Beneficiaries ─────────────────────────────────────────
      StatefulShellBranch(
        routes: [
          BeneficiariesRoute().create(
            path: BeneficiariesRoute.path,
            name: BeneficiariesRoute.name,
            routes: [
              TopUpRoute().create(
                path: TopUpRoute.path,
                name: TopUpRoute.name,
              ),
            ],
          ),
        ],
      ),

      // ── Branch 2: History ───────────────────────────────────────────────
      StatefulShellBranch(
        routes: [
          HistoryRoute().create(
            path: HistoryRoute.path,
            name: HistoryRoute.name,
          ),
        ],
      ),

      // ── Branch 3: Profile ───────────────────────────────────────────────
      StatefulShellBranch(
        routes: [
          ProfileRoute().create(
            path: ProfileRoute.path,
            name: ProfileRoute.name,
          ),
        ],
      ),
    ],
  ),
];

