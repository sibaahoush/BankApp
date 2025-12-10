import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات وهمية — سيتم استبدالها بالـ API لاحقاً
    final items = [
      {
        "title": "Transfer to Ali",
        "subtitle": "Completed",
        "amount": "-\$120.00",
        "type": "Outcome",
      },
      {
        "title": "Salary",
        "subtitle": "Approved",
        "amount": "+\$2500.00",
        "type": "Income",
      },
      {
        "title": "Electricity bill",
        "subtitle": "Pending approval",
        "amount": "-\$42.00",
        "type": "Pending",
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final tr = items[i];

        Color color = AppColors.textDark;
        if (tr["type"] == "Income") color = AppColors.success;
        if (tr["type"] == "Outcome") color = AppColors.error;
        if (tr["type"] == "Pending") color = AppColors.warning;

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.cardLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(
                tr["type"] == "Income"
                    ? Icons.arrow_downward
                    : tr["type"] == "Outcome"
                        ? Icons.arrow_upward
                        : Icons.pending_actions,
                color: color,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tr["title"]!, style: AppTextStyles.bodyMedium),
                    Text(tr["subtitle"]!,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textGrey,
                        )),
                  ],
                ),
              ),
              Text(
                tr["amount"]!,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
