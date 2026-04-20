import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Flexible(
          child: Text(
            'My Beneficiaries',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: AppSize.s08),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppPadding.p04,
            horizontal: AppPadding.p08,
          ),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppRadius.r60),
          ),
          child: BlocSelector<BeneficiaryCubit, BeneficiaryState, int>(
            selector: (state) {
              if (state is BeneficiaryLoaded) {
                return state.beneficiaries.length;
              }
              return 0;
            },
            builder: (context, count) {
              return Text('$count/5', style: context.labelLarge);
            },
          ),
        ),
      ],
    );
  }
}
