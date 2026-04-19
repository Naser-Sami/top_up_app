import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';
import 'package:top_up_app/features/beneficiaries/_beneficiaries.dart'; // Adjust imports as needed

class AddBeneficiaryBottomSheet extends StatefulWidget {
  const AddBeneficiaryBottomSheet({super.key});

  @override
  State<AddBeneficiaryBottomSheet> createState() =>
      _AddBeneficiaryBottomSheetState();
}

class _AddBeneficiaryBottomSheetState extends State<AddBeneficiaryBottomSheet> {
  final _phoneController = TextEditingController();
  final _nicknameController = TextEditingController();

  // Controls whether the Add button is clickable
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validateForm);
    _nicknameController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid =
          _phoneController.text.trim().isNotEmpty &&
          _nicknameController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_isFormValid) return;

    context.read<BeneficiaryCubit>().addBeneficiary(
      AddBeneficiaryParams(
        nickname: _nicknameController.text.trim(),
        phoneNumber: '+971${_phoneController.text.trim()}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // viewInsets.bottom handles pushing the UI up when the keyboard appears
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final colors = context.theme.colorScheme;

    return BlocListener<BeneficiaryCubit, BeneficiaryState>(
      listener: (context, state) {
        if (state is BeneficiaryAdded) {
          Navigator.of(context).pop();
        } else if (state is BeneficiaryError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: bottomPadding,
          left: 24,
          right: 24,
          top: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Add New Beneficiary', style: context.titleLarge),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Phone Number Field
            Text('UAE Phone Number', style: context.textTheme.titleSmall),
            const SizedBox(height: 8),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefix: Text(
                  '+971  ',
                  style: TextStyle(color: colors.onSurface, fontSize: 16),
                ),
                hintText: 'XX XXX XXXX',
                filled: true,
                fillColor: colors.surfaceDim,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Nickname Field
            Text('Nickname', style: context.textTheme.titleSmall),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nicknameController,
              maxLength: 20,
              decoration: InputDecoration(
                hintText: 'Enter a friendly name',
                helperText: 'This name will appear on your top-up screen.',
                filled: true,
                fillColor: colors.surfaceDim,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Submit Button
            BlocSelector<BeneficiaryCubit, BeneficiaryState, bool>(
              selector: (state) => state is BeneficiaryLoading,
              builder: (context, isLoading) {
                return ElevatedButton(
                  onPressed: (isLoading || !_isFormValid) ? null : _submit,
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Add Beneficiary'),
                );
              },
            ),
            const SizedBox(height: 32), // Bottom breathing room
          ],
        ),
      ),
    );
  }
}
