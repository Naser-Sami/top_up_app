import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';
import 'package:top_up_app/features/history/_history.dart';
import 'package:top_up_app/features/profile/_profile.dart';

class TopUpScreen extends StatefulWidget {
  final BeneficiaryEntity beneficiary;

  const TopUpScreen({super.key, required this.beneficiary});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.select<UserCubit, UserEntity?>(
      (c) => c.state is UserLoaded ? (c.state as UserLoaded).user : null,
    );
    final allBeneficiaries = context
        .select<BeneficiaryCubit, List<BeneficiaryEntity>>(
          (c) => c.state is BeneficiaryLoaded
              ? (c.state as BeneficiaryLoaded).beneficiaries
              : [],
        );
    final transactionState = context.watch<TransactionCubit>().state;

    final now = DateTime.now();
    final monthlyTransactions =
        (transactionState is TransactionLoaded
                ? transactionState.transactions
                : <TransactionEntity>[])
            .where(
              (t) =>
                  t.createdAt.month == now.month &&
                  t.createdAt.year == now.year,
            )
            .toList();

    final limit = (user?.isVerified ?? false) ? 1000.0 : 500.0;
    final spentThisMonth = monthlyTransactions
        .where((t) => t.beneficiaryId == widget.beneficiary.id)
        .fold(0.0, (sum, t) => sum + t.amount);

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Top Up — ${widget.beneficiary.nickname}'),
        centerTitle: false,
      ),
      body: BlocListener<TransactionCubit, TransactionState>(
        listener: (context, state) {
          if (state is TopUpSuccess) {
            final total = state.transaction.amount + state.transaction.fee;
            context.read<UserCubit>().deductBalance(total);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Top up successful!')));
            context.pop();
          } else if (state is TransactionError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BeneficiaryInfoCard(
                beneficiary: widget.beneficiary,
                spentThisMonth: spentThisMonth,
                limit: limit,
                isVerified: user.isVerified,
              ),
              const SizedBox(height: AppSize.s24),
              AmountSelector(
                user: user,
                beneficiary: widget.beneficiary,
                allBeneficiaries: allBeneficiaries,
                monthlyTransactions: monthlyTransactions,
                transactionState: transactionState,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
