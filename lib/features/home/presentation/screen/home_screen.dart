import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/core/utils/extensions/date_time_extensions.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';
import 'package:top_up_app/features/history/_history.dart';
import 'package:top_up_app/features/home/presentation/widgets/_widgets.dart';
import 'package:top_up_app/features/profile/_profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  Future<void> _fetchData() async {
    await Future.wait([
      // Fetch user data
      context.read<UserCubit>().fetchUser(),

      // Fetch transactions data
      context.read<TransactionCubit>().fetchTransactions(),

      // Fetch beneficiaries data
      context.read<BeneficiaryCubit>().fetchBeneficiaries(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocSelector<UserCubit, UserState, String>(
          selector: (state) {
            final user = state is UserLoaded ? state.user : null;
            return user?.name ?? 'User';
          },
          builder: (context, username) {
            final timeBasedGreeting = DateTime.now().greeting;
            return Text('$timeBasedGreeting, $username 👋');
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(AppPadding.p16),
        child: SingleChildScrollView(
          child: Column(
            spacing: AppSize.s16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AvailableBalanceCard(),
              VerifiedAccountCard(),
              BeneficiariesCard(),
              RecentTransactionsCard(),
            ],
          ),
        ),
      ),
    );
  }
}
