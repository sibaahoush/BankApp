import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
class RecentTransactionsSection extends StatelessWidget {
  const RecentTransactionsSection();

  @override
  Widget build(BuildContext context) {
    final transactions = [
      {
        "title": "Starbucks",
        "subtitle": "Coffee shop",
        "amount": "-\$ 12.50",
        "isIncome": false,
        "date": "Today",
      },
      {
        "title": "Salary",
        "subtitle": "Company Ltd.",
        "amount": "+\$ 800.00",
        "isIncome": true,
        "date": "Yesterday",
      },
      {
        "title": "Netflix",
        "subtitle": "Subscription",
        "amount": "-\$ 9.99",
        "isIncome": false,
        "date": "Yesterday",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent transactions",
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: 10),
        Column(
          children: transactions
              .map(
                (t) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.form,
                      child: Icon(
                        (t["isIncome"] as bool)
                            ? Icons.arrow_downward_rounded
                            : Icons.arrow_upward_rounded,
                        color: (t["isIncome"] as bool)
                            ? AppColors.success
                            : AppColors.error,
                        size: 18,
                      ),
                    ),
                    title: Text(
                      t["title"] as String,
                      style: AppTextStyles.bodyMedium,
                    ),
                    subtitle: Text(
                      "${t["subtitle"]} • ${t["date"]}",
                      style: AppTextStyles.bodySmall,
                    ),
                    trailing: Text(
                      t["amount"] as String,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: (t["isIncome"] as bool)
                            ? AppColors.success
                            : AppColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
