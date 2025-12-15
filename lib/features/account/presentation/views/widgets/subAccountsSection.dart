import 'package:flutter/material.dart';
import 'package:se3/core/models/account.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class SubAccountsSection extends StatelessWidget {
  final List<Account> subAccounts;

  const SubAccountsSection({super.key, required this.subAccounts});

  @override
  Widget build(BuildContext context) {
    if (subAccounts.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sub-accounts", style: AppTextStyles.titleMedium),
          const SizedBox(height: 8),
          Text(
            "No sub-accounts yet.",
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.border,
            ),
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
                (account) => Container(
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            account.type.toUpperCase(),
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            account.number,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.border,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$ ${account.balance.toStringAsFixed(2)}",
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
