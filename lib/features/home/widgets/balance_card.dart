import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Balance",
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "\$ 12,450.80",
            style: AppTextStyles.headlineSmall.copyWith(
              color: Colors.white,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.arrow_upward, size: 18, color: AppColors.success),
              const SizedBox(width: 4),
              Text(
                "+\$320 today",
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.lightprimary,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
