import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';
import 'package:top_up_app/features/history/_history.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final cubit = context.read<TransactionCubit>();
    if (cubit.state is TransactionInitial) {
      cubit.fetchTransactions();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colorScheme;

    final beneficiaries = context
        .select<BeneficiaryCubit, List<BeneficiaryEntity>>(
          (c) => c.state is BeneficiaryLoaded
              ? (c.state as BeneficiaryLoaded).beneficiaries
              : [],
        );

    return Scaffold(
      appBar: AppBar(title: const Text('Transaction History')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All your top-up transactions',
              style: textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSize.s16),
            BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
                if (state is TransactionLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is TransactionError) {
                  return Center(child: Text(state.message));
                }

                if (state is TransactionLoaded) {
                  final transactions = state.transactions;

                  if (transactions.isEmpty) {
                    return const Center(child: Text('No transactions found.'));
                  }

                  return Expanded(
                    child: ListView.separated(
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

                        return TransactionCard(
                          transaction: transaction,
                          beneficiary: beneficiary,
                        );
                      },
                      separatorBuilder: (context, _) =>
                          const SizedBox(height: AppSize.s16),
                      itemCount: transactions.length,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
