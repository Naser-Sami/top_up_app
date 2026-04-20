import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';
import 'package:top_up_app/core/widgets/base_container.dart';
import 'package:top_up_app/features/profile/_profile.dart';

class ProfileMenuCard extends StatelessWidget {
  final int notificationCount;

  const ProfileMenuCard({super.key, this.notificationCount = 0});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    final items = [
      const ProfileMenuItem(
        icon: Icons.security_outlined,
        title: 'Security & Privacy',
      ),
      ProfileMenuItem(
        icon: Icons.notifications_outlined,
        title: 'Notifications',
        badgeCount: notificationCount > 0 ? notificationCount : null,
      ),
      const ProfileMenuItem(
        icon: Icons.help_outline_rounded,
        title: 'Help & Support',
      ),
    ];

    return BaseContainer(
      child: Column(
        children: List.generate(items.length, (i) {
          return Column(
            children: [
              _MenuRow(item: items[i]),
              if (i < items.length - 1)
                Divider(
                  color: colors.outlineVariant,
                  thickness: 1,
                  height: 1,
                  indent: AppSize.s52,
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  final ProfileMenuItem item;
  const _MenuRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final textTheme = context.textTheme;

    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(AppRadius.r16),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p16,
        ),
        child: Row(
          children: [
            // Icon background circle
            Container(
              width: AppSize.s36,
              height: AppSize.s36,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(item.icon, size: AppSize.s18, color: colors.primary),
            ),

            const SizedBox(width: AppSize.s12),

            // Title
            Expanded(
              child: Text(
                item.title,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colors.onSurface,
                ),
              ),
            ),

            // Optional notification badge
            if (item.badgeCount != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p08,
                  vertical: AppPadding.p02,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(AppRadius.r30),
                ),
                child: Text(
                  '${item.badgeCount}',
                  style: textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: AppSize.s08),
            ],

            // Chevron
            Icon(
              Icons.chevron_right_rounded,
              color: colors.onSurfaceVariant,
              size: AppSize.s20,
            ),
          ],
        ),
      ),
    );
  }
}
