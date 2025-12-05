import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class AccountSummaryCard extends StatelessWidget {
  final double balance;
  final String iban;
  final String status;

  const AccountSummaryCard({
    required this.balance,
    required this.iban,
    required this.status,
  });

  Color _statusColor() {
    switch (status) {
      case "Frozen":
        return AppColors.warning;
      case "Closed":
        return AppColors.error;
      default:
        return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.lightprimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان صغير
          Text(
            "Total balance",
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 6),

          // الرصيد
          Text(
            "\$ ${balance.toStringAsFixed(2)}",
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 26,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 14),

          // IBAN + الحالة
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // IBAN
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "IBAN",
                      style: AppTextStyles.labelSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      iban,
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Status
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Status",
                    style: AppTextStyles.labelSmall,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _statusColor().withOpacity(0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8,
                          color: _statusColor(),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          status,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: _statusColor(),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
