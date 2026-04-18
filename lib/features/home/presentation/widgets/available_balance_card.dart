import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';
import 'package:top_up_app/features/profile/_profile.dart';

class AvailableBalanceCard extends StatelessWidget {
  const AvailableBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Card(
        color: context.theme.colorScheme.primaryContainer,
        child: ListTile(
          title: Text('Available Balance', style: context.titleSmall),
          subtitle: BlocSelector<UserCubit, UserState, double>(
            selector: (state) {
              final user = state is UserLoaded ? state.user : null;
              return user?.balance ?? 0.00;
            },
            builder: (context, balance) {
              return Text('AED $balance', style: context.headlineMedium);
            },
          ),
        ),
      ),
    );
  }
}
