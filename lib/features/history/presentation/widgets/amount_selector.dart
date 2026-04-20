import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart';
import 'package:top_up_app/features/history/_history.dart';
import 'package:top_up_app/features/profile/_profile.dart';

class AmountSelector extends StatefulWidget {
  final UserEntity user;
  final BeneficiaryEntity beneficiary;
  final List<BeneficiaryEntity> allBeneficiaries;
  final List<TransactionEntity> monthlyTransactions;
  final TransactionState transactionState;

  const AmountSelector({
    super.key,
    required this.user,
    required this.beneficiary,
    required this.allBeneficiaries,
    required this.monthlyTransactions,
    required this.transactionState,
  });

  @override
  State<AmountSelector> createState() => _AmountSelectorState();
}

class _AmountSelectorState extends State<AmountSelector> {
  double? _selectedAmount;

  @override
  Widget build(BuildContext context) {
    // All values come from widget.xxx — no context.select here
    final user = widget.user;
    final fee = TopUpOption.transactionFee;
    final isLoading = widget.transactionState is TransactionLoading;
    final hasInsufficientBalance =
        _selectedAmount != null && user.balance < (_selectedAmount! + fee);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Amount', style: context.titleLarge),
        const SizedBox(height: AppSize.s16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppSize.s12,
            mainAxisSpacing: AppSize.s12,
            childAspectRatio: 1.2,
          ),
          itemCount: TopUpOption.validOptions.length,
          itemBuilder: (context, index) {
            final amount = TopUpOption.validOptions[index];
            return _AmountChoice(
              amount: amount,
              isSelected: _selectedAmount == amount,
              onTap: () => setState(() => _selectedAmount = amount),
            );
          },
        ),
        const SizedBox(height: AppSize.s16),
        Row(
          children: [
            Icon(
              Icons.bolt,
              size: 16,
              color: context.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: AppSize.s04),
            Text(
              'AED ${fee.toInt()} transaction fee applies',
              style: context.bodySmall.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s24),
        if (_selectedAmount != null) ...[
          SummaryCard(
            amount: _selectedAmount!,
            fee: fee,
            balance: user.balance,
          ),
          const SizedBox(height: AppSize.s24),
          ElevatedButton(
            onPressed: isLoading || hasInsufficientBalance
                ? null
                : () {
                    context.read<TransactionCubit>().topUp(
                      TopUpParams(
                        user: user,
                        beneficiaryId: widget.beneficiary.id,
                        amount: _selectedAmount!,
                        allBeneficiaries: widget.allBeneficiaries,
                        monthlyTransactions: widget.monthlyTransactions,
                      ),
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorScheme.tertiary,
              foregroundColor: context.colorScheme.onTertiary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
              ),
              minimumSize: const Size(double.infinity, 45),
            ),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Confirm Top-Up'),
          ),
          const SizedBox(height: AppSize.s16),
          Center(
            child: Text(
              'Monthly remaining after top-up: AED ${((user.isVerified ? 1000.0 : 500.0) - widget.monthlyTransactions.where((t) => t.beneficiaryId == widget.beneficiary.id).fold(0.0, (s, t) => s + t.amount) - _selectedAmount!).toInt()} of AED ${(user.isVerified ? 1000 : 500)}',
              style: context.bodySmall.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _AmountChoice extends StatelessWidget {
  final double amount;
  final bool isSelected;
  final VoidCallback onTap;

  const _AmountChoice({
    required this.amount,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.r12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.r12),
          border: Border.all(
            color: isSelected
                ? context.colorScheme.primary
                : context.colorScheme.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
          color: context.colorScheme.surface,
          // color: isSelected
          //     ? context.colorScheme.primaryContainer.withValues(alpha: 0.1)
          //     : null,
        ),
        alignment: Alignment.center,
        child: Text(
          'AED ${amount.toInt()}',
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: isSelected
                ? context.colorScheme.primary
                : context.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
