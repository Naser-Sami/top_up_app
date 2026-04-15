import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/features/home/presentation/widgets/_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Good evening, Ahmed 👋')),
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
