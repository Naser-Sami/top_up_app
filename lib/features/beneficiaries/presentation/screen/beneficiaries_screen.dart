import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/constants/app_dimensions/app_dimensions.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';
import 'package:top_up_app/core/utils/extensions/string_extensions.dart';
import 'package:top_up_app/core/widgets/add_beneficiary_bottom_sheet.dart';
import 'package:top_up_app/core/routes/routes/top_up_route.dart';
import 'package:top_up_app/core/widgets/avatar_widget.dart';
import 'package:top_up_app/core/widgets/base_container.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';
import 'package:top_up_app/features/history/_history.dart';
import 'package:top_up_app/features/profile/_profile.dart';

class BeneficiariesScreen extends StatelessWidget {
  const BeneficiariesScreen({super.key});

  void _showAddSheet(BuildContext context) {
    final cubit = context.read<BeneficiaryCubit>();

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (bottomSheetContext) {
        return BlocProvider.value(
          value: cubit,
          child: const AddBeneficiaryBottomSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppBarTitle()),
      floatingActionButton:
          BlocSelector<BeneficiaryCubit, BeneficiaryState, int>(
            selector: (state) =>
                state is BeneficiaryLoaded ? state.beneficiaries.length : 0,
            builder: (context, count) {
              final isAtCap = count >= 5;
              return FloatingActionButton(
                onPressed: isAtCap
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'You can only have up to 5 beneficiaries.',
                            ),
                          ),
                        );
                      }
                    : () => _showAddSheet(context),
                child: const Icon(Icons.add),
              );
            },
          ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: BeneficiariesList(),
      ),
    );
  }
}

class BeneficiariesList extends StatelessWidget {
  const BeneficiariesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
      builder: (context, beneficiaryState) {
        if (beneficiaryState is BeneficiaryLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (beneficiaryState is BeneficiaryError) {
          return Center(
            child: Text('Something went wrong.\n${beneficiaryState.message}'),
          );
        }

        if (beneficiaryState is BeneficiaryLoaded) {
          final beneficiaries = beneficiaryState.beneficiaries;
          final user = context.select<UserCubit, UserEntity?>(
            (cubit) => cubit.state is UserLoaded
                ? (cubit.state as UserLoaded).user
                : null,
          );
          final transactions = context
              .select<TransactionCubit, List<TransactionEntity>>(
                (cubit) => cubit.state is TransactionLoaded
                    ? (cubit.state as TransactionLoaded).transactions
                    : [],
              );

          if (beneficiaries.isEmpty) {
            return const Center(child: Text('No beneficiaries found.'));
          }

          return ListView.separated(
            itemCount: beneficiaries.length,
            padding: const EdgeInsets.only(bottom: AppPadding.p16),
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSize.s16),
            itemBuilder: (context, index) {
              final beneficiary = beneficiaries[index];
              final now = DateTime.now();

              // Calculate spent this month for this beneficiary
              final spentThisMonth = transactions
                  .where(
                    (t) =>
                        t.beneficiaryId == beneficiary.id &&
                        t.createdAt.month == now.month &&
                        t.createdAt.year == now.year,
                  )
                  .fold(0.0, (sum, t) => sum + t.amount);

              final limit = (user?.isVerified ?? false) ? 1000.0 : 500.0;

              return _BeneficiaryCard(
                beneficiary: beneficiary,
                spentThisMonth: spentThisMonth,
                limit: limit,
                onTopUp: () => TopUpRoute.go(context, beneficiary),
              );
            },
          );
        }

        return const Center(child: Text('Something went wrong.'));
      },
    );
  }
}

class _BeneficiaryCard extends StatelessWidget {
  final BeneficiaryEntity beneficiary;
  final double spentThisMonth;
  final double limit;
  final void Function()? onTopUp;

  const _BeneficiaryCard({
    required this.beneficiary,
    required this.spentThisMonth,
    required this.limit,
    required this.onTopUp,
  });

  @override
  Widget build(BuildContext context) {
    final usageRatio = spentThisMonth / limit;
    final isHighUsage = usageRatio >= 0.8;
    final color = isHighUsage
        ? context.colorScheme.error
        : context.colorScheme.tertiary;

    return BaseContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: AvatarWidget(
              child: Text(
                beneficiary.nickname.initials,
                style: context.titleMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            title: Text(beneficiary.nickname),
            subtitle: Row(
              children: [
                const Icon(Icons.phone, size: 16),
                const SizedBox(width: AppSize.s08),
                Text(beneficiary.phoneNumber),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AED ${spentThisMonth.toInt()} / AED ${limit.toInt()} this month',
                  style: context.labelMedium.copyWith(
                    color: isHighUsage ? color : null,
                    fontWeight: isHighUsage ? FontWeight.bold : null,
                  ),
                ),
                const SizedBox(height: AppSize.s08),
                Stack(
                  children: [
                    Container(
                      height: AppSize.s08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(AppRadius.r08),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: usageRatio.clamp(0, 1),
                      child: Container(
                        height: AppSize.s08,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(AppRadius.r08),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSize.s12),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p16,
              vertical: AppPadding.p08,
            ),
            child: ElevatedButton(
              onPressed: onTopUp,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
              ),
              child: const Text('Top Up'),
            ),
          ),
          const SizedBox(height: AppSize.s08),
        ],
      ),
    );
  }
}
