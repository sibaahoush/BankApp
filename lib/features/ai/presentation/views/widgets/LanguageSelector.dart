import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/ai_bot_controller.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final AiBotController controller = Get.find<AiBotController>();

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
          Obx(() => GestureDetector(
                onTap: () => controller.changeLanguage('ar'),
                child: Chip(
                  label: Text("AR", style: AppTextStyles.bodySmall),
                  backgroundColor: controller.selectedLanguage.value == 'ar'
                      ? AppColors.primary.withOpacity(0.1)
                      : AppColors.form,
                ),
              )),
          const SizedBox(width: 6),
          Obx(() => GestureDetector(
                onTap: () => controller.changeLanguage('en'),
                child: Chip(
                  label: Text("EN", style: AppTextStyles.bodySmall),
                  backgroundColor: controller.selectedLanguage.value == 'en'
                      ? AppColors.primary.withOpacity(0.1)
                      : AppColors.form,
                ),
              )),
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
