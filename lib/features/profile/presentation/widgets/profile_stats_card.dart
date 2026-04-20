import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';

class ProfileStatsCard extends StatelessWidget {
  /// Total AED spent this month across all beneficiaries.
  final double totalSpent;

  /// Number of top-up transactions this month.
  final int transactionCount;

  /// Number of beneficiaries the user has.
  final int beneficiaryCount;

  const ProfileStatsCard({
    super.key,
    required this.totalSpent,
    required this.transactionCount,
    required this.beneficiaryCount,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p20,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            LightThemeColors.primary, // deep blue
            LightThemeColors.secondary, // medium blue
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.r16),
        boxShadow: [
          BoxShadow(
            color: LightThemeColors.primary.withAlpha(76), // ~30%
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Spent This Month',
            style: textTheme.bodyMedium?.copyWith(
              color: LightThemeColors.onPrimary.withAlpha(204), // 80%
            ),
          ),
          const SizedBox(height: AppSize.s06),
          Text(
            'AED ${totalSpent.toStringAsFixed(2)}',
            style: textTheme.displaySmall?.copyWith(
              color: LightThemeColors.onPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSize.s12),
          Row(
            children: [
              _StatChip(
                label:
                    '$transactionCount transaction${transactionCount == 1 ? '' : 's'}',
              ),
              const Spacer(),
              _StatChip(
                label:
                    '$beneficiaryCount beneficiary${beneficiaryCount == 1 ? '' : 'ies'}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  const _StatChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Text(
      label,
      style: textTheme.bodySmall?.copyWith(
        color: LightThemeColors.onPrimary.withAlpha(204), // 80%
      ),
    );
  }
}
