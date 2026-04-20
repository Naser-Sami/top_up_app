import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';
import 'package:top_up_app/core/utils/extensions/string_extensions.dart';
import 'package:top_up_app/core/widgets/avatar_widget.dart';
import 'package:top_up_app/core/widgets/base_container.dart';
import 'package:top_up_app/features/profile/domain/domain.dart';

class ProfileInfoCard extends StatelessWidget {
  final UserEntity user;

  const ProfileInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final textTheme = context.textTheme;

    return BaseContainer(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AvatarWidget(
                width: AppSize.s60,
                height: AppSize.s60,
                child: Text(
                  user.name.initials,
                  style: AppTextStyle.titleLarge().copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: AppSize.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSize.s02),
                    Text(
                      'Member since January 2024',
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              _VerifiedBadge(isVerified: user.isVerified),
            ],
          ),

          const SizedBox(height: AppSize.s16),

          Divider(color: colors.outlineVariant, thickness: 1, height: 1),

          const SizedBox(height: AppSize.s12),

          _ContactRow(
            icon: Icons.email_outlined,
            label: '${user.name}@email.com',
          ),
          const SizedBox(height: AppSize.s10),
          _ContactRow(
            icon: Icons.account_balance_wallet_outlined,
            label: 'Balance: AED ${user.balance.toStringAsFixed(2)}',
          ),
          const SizedBox(height: AppSize.s10),
          const _ContactRow(
            icon: Icons.phone_outlined,
            label: '+971 50 987 6543',
          ),
          const SizedBox(height: AppSize.s10),
          const _ContactRow(
            icon: Icons.location_on_outlined,
            label: 'Dubai, UAE',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Internal widgets
// ─────────────────────────────────────────────────────────────────────────────

class _VerifiedBadge extends StatelessWidget {
  final bool isVerified;
  const _VerifiedBadge({required this.isVerified});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return Icon(
      isVerified ? Icons.check_circle_outline_rounded : Icons.cancel_outlined,
      color: isVerified ? colors.tertiary : colors.error,
      size: AppSize.s24,
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ContactRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final textTheme = context.textTheme;

    return Row(
      children: [
        Icon(icon, size: AppSize.s18, color: colors.onSurfaceVariant),
        const SizedBox(width: AppSize.s10),
        Flexible(
          child: Text(
            label,
            style: textTheme.bodyMedium?.copyWith(color: colors.onSurface),
          ),
        ),
      ],
    );
  }
}
