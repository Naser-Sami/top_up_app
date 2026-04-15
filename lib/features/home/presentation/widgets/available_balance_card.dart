import 'package:flutter/material.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';

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
          subtitle: Text('AED 1240.00', style: context.headlineMedium),
        ),
      ),
    );
  }
}
