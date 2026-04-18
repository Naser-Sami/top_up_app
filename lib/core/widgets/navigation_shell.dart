import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The root scaffold that hosts the persistent [BottomNavigationBar].
///
/// Each tap calls [navigationShell.goBranch] to switch the current branch
/// in the [StatefulShellRoute.indexedStack] while preserving the navigation
/// state of every tab.
class NavigationShell extends StatelessWidget {
  const NavigationShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  /// Ordered list of nav-bar items — must match the branch order defined in
  /// [routes.dart].
  static const List<_NavItem> _items = [
    _NavItem(
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
    ),
    _NavItem(
      label: 'Beneficiaries',
      icon: Icons.people_outline_rounded,
      activeIcon: Icons.people_rounded,
    ),
    _NavItem(
      label: 'History',
      icon: Icons.history_outlined,
      activeIcon: Icons.history_rounded,
    ),
    _NavItem(
      label: 'Profile',
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _AnimatedNavBar(
        currentIndex: currentIndex,
        items: _items,
        onTap: _onTap,
        colorScheme: colorScheme,
      ),
    );
  }

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      // Return to the initial location of a branch that is already active.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

// ---------------------------------------------------------------------------
// Internal helpers
// ---------------------------------------------------------------------------

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
}

/// A stateless wrapper that renders a themed, animated [BottomNavigationBar].
///
/// The active icon animates with a subtle scale-up effect so users get clear
/// visual feedback without sacrificing performance (pure widget rebuild, no
/// extra controllers needed).
class _AnimatedNavBar extends StatelessWidget {
  const _AnimatedNavBar({
    required this.currentIndex,
    required this.items,
    required this.onTap,
    required this.colorScheme,
  });

  final int currentIndex;
  final List<_NavItem> items;
  final ValueChanged<int> onTap;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).bottomNavigationBarTheme;

    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = index == currentIndex;
              return _NavBarItem(
                item: item,
                isSelected: isSelected,
                onTap: () => onTap(index),
                selectedColor: theme.selectedItemColor ?? colorScheme.primary,
                unselectedColor:
                    theme.unselectedItemColor ?? colorScheme.onSurfaceVariant,
                selectedLabelStyle: theme.selectedLabelStyle,
                unselectedLabelStyle: theme.unselectedLabelStyle,
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedColor,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
  });

  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? selectedColor : unselectedColor;
    final labelStyle = (isSelected ? selectedLabelStyle : unselectedLabelStyle)
        ?.copyWith(color: color);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: selectedColor.withValues(alpha: 0.12),
        highlightColor: selectedColor.withValues(alpha: 0.06),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.18 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutBack,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: Icon(
                    isSelected ? item.activeIcon : item.icon,
                    key: ValueKey(isSelected),
                    color: color,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                style: (labelStyle ?? TextStyle(color: color)).copyWith(
                  fontSize: 11,
                ),
                duration: const Duration(milliseconds: 200),
                child: Text(item.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
