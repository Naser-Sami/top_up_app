import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';

import 'add_beneficiary_bottom_sheet.dart';

class BeneficiariesCard extends StatelessWidget {
  const BeneficiariesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(
          AppPadding.p16,
        ).copyWith(top: AppPadding.p04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('My Beneficiaries', style: context.titleMedium),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    final cubit = context.read<BeneficiaryCubit>();

                    showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      builder: (bottomSheetContext) {
                        return BlocProvider.value(
                          value: cubit,
                          child: const AddBeneficiaryBottomSheet(),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.add_circle_outline_rounded),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s12),
            SizedBox(
              width: context.width,
              height: 90,
              child: const _BeneficiaryList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _BeneficiaryList extends StatelessWidget {
  const _BeneficiaryList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
      builder: (context, state) {
        if (state is BeneficiaryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BeneficiaryLoaded) {
          final beneficiaries = state.beneficiaries;
          if (beneficiaries.isEmpty) {
            return const Center(child: Text('No beneficiaries found'));
          }
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: beneficiaries.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppSize.s12),
            itemBuilder: (context, index) {
              final beneficiary = beneficiaries[index];
              return SizedBox(
                width: 80,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Text(beneficiary.nickname[0].toUpperCase()),
                    ),
                    const SizedBox(height: AppSize.s08),
                    Text(
                      beneficiary.nickname,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is BeneficiaryError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
