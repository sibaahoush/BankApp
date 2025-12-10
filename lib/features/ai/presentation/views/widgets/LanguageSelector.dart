import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.cardLight,
      child: Row(
        children: [
          Text(
            "Language",
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(width: 8),
          Chip(
            label: Text("AR", style: AppTextStyles.bodySmall),
            backgroundColor: AppColors.primary.withOpacity(0.1),
          ),
          const SizedBox(width: 6),
          Chip(
            label: Text("EN", style: AppTextStyles.bodySmall),
            backgroundColor: AppColors.form,
          ),
          const Spacer(),
          Icon(Icons.smart_toy_outlined, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            "Financial tips",
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}
