import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      {"icon": Icons.send_rounded, "label": "Transfer"},
      {"icon": Icons.add_circle_rounded, "label": "Deposit"},
      {"icon": Icons.money_off_csred_rounded, "label": "Withdraw"},
      {"icon": Icons.qr_code_scanner_rounded, "label": "Scan"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick actions",
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: actions
              .map(
                (a) => Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.cardLight,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        a["icon"] as IconData,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      a["label"] as String,
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
