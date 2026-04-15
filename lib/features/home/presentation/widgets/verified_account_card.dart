import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';

class VerifiedAccountCard extends StatelessWidget {
  const VerifiedAccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p08,
        vertical: AppPadding.p04,
      ),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.r30),
        border: Border.all(color: context.theme.colorScheme.tertiary, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: context.theme.colorScheme.tertiary,
            size: AppSize.s16,
          ),
          const SizedBox(width: AppSize.s04),
          Text(
            'Verified Account',
            style: context.bodyMedium.copyWith(
              color: context.theme.colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
