import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';
import 'package:top_up_app/features/history/domain/entities/transaction_entity.dart';
import 'package:top_up_app/features/history/presentation/widgets/transaction_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // Sample data — replace with BLoC-driven list when ready.
    const sampleBeneficiary = BeneficiaryEntity(
      id: '1',
      nickname: 'Sarah',
      phoneNumber: '+971 50 123 4567',
    );

    final sampleTransaction = TransactionEntity(
      id: 'TXN123456789',
      beneficiaryId: '1',
      amount: 50,
      fee: 1,
      createdAt: DateTime(2026, 4, 15, 10, 30),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Transaction History')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All your top-up transactions',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSize.s16),
            TransactionCard(
              transaction: sampleTransaction,
              beneficiary: sampleBeneficiary,
            ),
          ],
        ),
      ),
    );
  }
}
