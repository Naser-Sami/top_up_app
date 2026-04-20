import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';
import 'package:top_up_app/core/utils/extensions/date_time_extensions.dart';
import 'package:top_up_app/core/utils/extensions/string_extensions.dart';
import 'package:top_up_app/core/widgets/avatar_widget.dart';
import 'package:top_up_app/core/widgets/base_container.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';
import 'package:top_up_app/features/history/_history.dart';

class RecentTransactionsCard extends StatelessWidget {
  const RecentTransactionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recent Transactions', style: context.titleMedium),
            const SizedBox(height: AppSize.s12),
            SizedBox(
              width: context.width,
              child: const _RecentTransactionsList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentTransactionsList extends StatelessWidget {
  const _RecentTransactionsList();

  @override
  Widget build(BuildContext context) {
    final beneficiaries = context
        .select<BeneficiaryCubit, List<BeneficiaryEntity>>(
          (c) => c.state is BeneficiaryLoaded
              ? (c.state as BeneficiaryLoaded).beneficiaries
              : [],
        );

    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TransactionLoaded) {
          final transactions = state.transactions;

          if (transactions.isEmpty) {
            return const Center(child: Text('No transactions found.'));
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              final beneficiary = beneficiaries.firstWhere(
                (b) => b.id == transaction.beneficiaryId,
                orElse: () => const BeneficiaryEntity(
                  id: '',
                  nickname: 'Unknown',
                  phoneNumber: '',
                ),
              );

              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: AvatarWidget(
                  child: Text(
                    beneficiary.nickname.initials,
                    style: AppTextStyle.titleMedium().copyWith(
                      color: LightThemeColors.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                title: Text(beneficiary.nickname),
                subtitle: Text(transaction.createdAt.toRelativeTime()),
                trailing: Text('AED ${transaction.amount.toStringAsFixed(0)}'),
              );
            },
          );
        } else if (state is TransactionError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
