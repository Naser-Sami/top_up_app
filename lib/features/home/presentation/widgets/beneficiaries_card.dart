import 'package:flutter/material.dart';
import 'package:top_up_app/core/constants/_constants.dart';
import 'package:top_up_app/core/utils/extensions/build_context.dart';

class BeneficiariesCard extends StatelessWidget {
  const BeneficiariesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(
          AppPadding.p16,
        ).copyWith(top: AppPadding.p04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('My Beneficiaries', style: context.titleMedium),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_outline_rounded),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s12),
            SizedBox(
              width: context.width,
              height: 90,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: AppSize.s24),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.theme.colorScheme.primaryContainer,
                        ),
                      ),
                      const SizedBox(height: AppSize.s12),
                      Text('Name ${index + 1}'),
                    ],
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
