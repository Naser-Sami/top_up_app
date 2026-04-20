import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';
import 'package:top_up_app/features/history/_history.dart';
import 'package:top_up_app/features/profile/_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final userCubit = context.read<UserCubit>();
    if (userCubit.state is UserInitial) {
      userCubit.fetchUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    // Derive stats here — outside BlocBuilder so they react to cubit changes
    final transactions =
        context.select<TransactionCubit, List<TransactionEntity>>(
      (c) => c.state is TransactionLoaded
          ? (c.state as TransactionLoaded).transactions
          : [],
    );
    final beneficiaries =
        context.select<BeneficiaryCubit, List<BeneficiaryEntity>>(
      (c) => c.state is BeneficiaryLoaded
          ? (c.state as BeneficiaryLoaded).beneficiaries
          : [],
    );
    final now = DateTime.now();
    final monthlyTransactions = transactions.where(
      (t) => t.createdAt.year == now.year && t.createdAt.month == now.month,
    );
    final totalSpent =
        monthlyTransactions.fold<double>(0, (sum, t) => sum + t.amount + t.fee);

    return Scaffold(
      backgroundColor: colors.surfaceDim,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: colors.surfaceDim,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserLoading || userState is UserInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userState is UserError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: AppSize.s48,
                    color: colors.error,
                  ),
                  const SizedBox(height: AppSize.s12),
                  Text(
                    userState.message,
                    style: TextStyle(color: colors.error),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          final user = (userState as UserLoaded).user;

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p16,
              vertical: AppPadding.p12,
            ),
            children: [
              ProfileInfoCard(user: user),
              const SizedBox(height: AppSize.s16),
              ProfileStatsCard(
                totalSpent: totalSpent,
                transactionCount: monthlyTransactions.length,
                beneficiaryCount: beneficiaries.length,
              ),
              const SizedBox(height: AppSize.s16),
              const ProfileMenuCard(notificationCount: 3),
              const SizedBox(height: AppSize.s24),
            ],
          );
        },
      ),
    );
  }
}
