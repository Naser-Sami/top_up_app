import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';

class RecentTransactionsCard extends StatelessWidget {
  const RecentTransactionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recent Transactions', style: context.titleMedium),
            const SizedBox(height: AppSize.s12),
            SizedBox(
              width: context.width,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 8,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.theme.colorScheme.primaryContainer,
                      ),
                    ),
                    title: Text('Transaction ${index + 1}'),
                    subtitle: const Text('Today, 10:30 AM'),
                    trailing: Text('AED ${100 * (index + 1)}.00'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
