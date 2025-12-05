import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
class SubAccountsSection extends StatelessWidget {
  const SubAccountsSection();

  @override
  Widget build(BuildContext context) {
    final subAccounts = [
      {"name": "Child savings", "balance": "\$ 300.00"},
      {"name": "Business sub-account", "balance": "\$ 1,200.00"},
    ];

    if (subAccounts.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sub-accounts", style: AppTextStyles.titleMedium),
          const SizedBox(height: 8),
          Text(
            "No sub-accounts yet.",
            style: AppTextStyles.bodySmall,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Sub-accounts", style: AppTextStyles.titleMedium),
        const SizedBox(height: 10),
        Column(
          children: subAccounts
              .map(
                (s) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.cardLight,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.border.withOpacity(0.25),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        s["name"] as String,
                        style: AppTextStyles.bodyMedium,
                      ),
                      Text(
                        s["balance"] as String,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
