import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';

class BeneficiaryInfoCard extends StatelessWidget {
  final BeneficiaryEntity beneficiary;
  final double spentThisMonth;
  final double limit;
  final bool isVerified;

  const BeneficiaryInfoCard({super.key, 
    required this.beneficiary,
    required this.spentThisMonth,
    required this.limit,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    final usageRatio = spentThisMonth / limit;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.r16),
        side: BorderSide(color: context.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: context.colorScheme.primary,
                  child: Text(
                    beneficiary.nickname
                        .substring(0, beneficiary.nickname.length.clamp(0, 2))
                        .toUpperCase(),
                    style: context.titleLarge.copyWith(
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: AppSize.s16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      beneficiary.nickname,
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      beneficiary.phoneNumber,
                      style: context.bodyMedium.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSize.s16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'AED ${spentThisMonth.toInt()} used of AED ${limit.toInt()}',
                  style: context.bodySmall.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isVerified ? '(Verified)' : '(Unverified)',
                  style: context.bodySmall.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s08),
            LinearProgressIndicator(
              value: usageRatio.clamp(0.0, 1.0),
              backgroundColor: context.colorScheme.surfaceContainerHigh,
              valueColor: AlwaysStoppedAnimation(context.colorScheme.primary),
              minHeight: 8,
              borderRadius: BorderRadius.circular(AppRadius.r08),
            ),
          ],
        ),
      ),
    );
  }
}
