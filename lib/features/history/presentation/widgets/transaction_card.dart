import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';
import 'package:top_up_app/core/widgets/base_container.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';
import 'package:top_up_app/features/history/domain/entities/transaction_entity.dart';

class TransactionCard extends StatelessWidget {
  final TransactionEntity transaction;
  final BeneficiaryEntity beneficiary;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.beneficiary,
  });

  /// Returns up to 2 uppercase initials from the beneficiary's nickname.
  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0].isNotEmpty ? parts[0][0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final formattedDate = DateFormat(
      'MMM d, y • hh:mm a',
    ).format(transaction.createdAt);
    final formattedAmount = 'AED ${transaction.amount.toStringAsFixed(0)}';

    return BaseContainer(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top row: Avatar  |  Name + Phone  |  Amount ──
            Row(
              children: [
                // Avatar
                Container(
                  width: AppSize.s52,
                  height: AppSize.s52,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        LightThemeColors.primary,
                        LightThemeColors.secondary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _initials(beneficiary.nickname),
                    style: AppTextStyle.titleMedium().copyWith(
                      color: LightThemeColors.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                const SizedBox(width: AppSize.s12),

                // Name + Phone
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        beneficiary.nickname,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSize.s02),
                      Text(
                        beneficiary.phoneNumber,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                // Amount
                Text(
                  formattedAmount,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSize.s16),

            // ── Divider ──
            Divider(color: colorScheme.outlineVariant, thickness: 1, height: 1),

            const SizedBox(height: AppSize.s12),

            // ── Bottom row: Tx ID + Date  |  Status icon ──
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Transaction ID + Date column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction ID',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSize.s02),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              transaction.id,
                              style: textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSize.s08),
                          Flexible(
                            flex: 2,
                            child: Text(
                              '• $formattedDate',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.s02),
                      Text(
                        'Fee AED ${transaction.fee.toStringAsFixed(0)}',
                        style: textTheme.titleSmall?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),

                // Success status badge
                const _StatusBadge(isSuccess: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A small circular badge showing the transaction status.
class _StatusBadge extends StatelessWidget {
  final bool isSuccess;
  const _StatusBadge({required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    final color = isSuccess ? colors.tertiary : colors.error;
    final bgColor = isSuccess
        ? colors.tertiaryContainer
        : colors.errorContainer;
    final icon = isSuccess
        ? Icons.check_circle_outline_rounded
        : Icons.cancel_outlined;

    return Container(
      width: AppSize.s36,
      height: AppSize.s36,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Icon(icon, color: color, size: AppSize.s20),
    );
  }
}
