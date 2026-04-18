import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';
import 'package:top_up_app/features/profile/_profile.dart';

class VerifiedAccountCard extends StatelessWidget {
  const VerifiedAccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserCubit, UserState, bool>(
      selector: (state) {
        final user = state is UserLoaded ? state.user : null;
        return user?.isVerified ?? false;
      },
      builder: (context, isVerified) {
        if (isVerified) {
          return const _VerifiedUser();
        } else {
          return const _UnverifiedUser();
        }
      },
    );
  }
}

class _VerifiedUser extends StatelessWidget {
  const _VerifiedUser();

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p08,
        vertical: AppPadding.p04,
      ),
      decoration: BoxDecoration(
        color: colors.tertiaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.r30),
        border: Border.all(color: colors.tertiary, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: colors.tertiary,
            size: AppSize.s16,
          ),
          const SizedBox(width: AppSize.s04),
          Text(
            'Verified Account',
            style: context.bodyMedium.copyWith(color: colors.tertiary),
          ),
        ],
      ),
    );
  }
}

class _UnverifiedUser extends StatelessWidget {
  const _UnverifiedUser();

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p08,
        vertical: AppPadding.p04,
      ),
      decoration: BoxDecoration(
        color: colors.errorContainer,
        borderRadius: BorderRadius.circular(AppRadius.r30),
        border: Border.all(color: colors.error, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, color: colors.error, size: AppSize.s16),
          const SizedBox(width: AppSize.s04),
          Text(
            'Unverified Account',
            style: context.bodyMedium.copyWith(color: colors.error),
          ),
        ],
      ),
    );
  }
}
