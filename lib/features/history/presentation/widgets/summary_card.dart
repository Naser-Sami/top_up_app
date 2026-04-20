import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';
import 'package:top_up_app/core/widgets/base_container.dart';

class SummaryCard extends StatelessWidget {
  final double amount;
  final double fee;
  final double balance;

  const SummaryCard({
    super.key,
    required this.amount,
    required this.fee,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    final total = amount + fee;
    final remaining = balance - total;

    return BaseContainer(
      color: const Color(0xFF1E3A8A),
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary',
            style: context.titleMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSize.s16),
          _SummaryRow(label: 'Top-up amount:', value: 'AED ${amount.toInt()}'),
          const SizedBox(height: AppSize.s08),
          _SummaryRow(label: 'Transaction fee:', value: 'AED ${fee.toInt()}'),
          const Divider(color: Colors.white24, height: AppSize.s24),
          _SummaryRow(
            label: 'Total deducted:',
            value: 'AED ${total.toInt()}',
            isBold: true,
          ),
          const SizedBox(height: AppSize.s08),
          _SummaryRow(
            label: 'Remaining balance:',
            value: 'AED ${remaining.toStringAsFixed(2)}',
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.bodyMedium.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
        Text(
          value,
          style: context.bodyMedium.copyWith(
            color: Colors.white,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 18 : null,
          ),
        ),
      ],
    );
  }
}
