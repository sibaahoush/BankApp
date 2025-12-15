import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:se3/features/home/controllers/home_controller.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

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
          Obx(() => controller.isLoading.value
              ? const SizedBox(
                  height: 32,
                  child: Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                )
              : Text(
                  "\$ ${controller.totalBalance.value.toStringAsFixed(2)}",
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                )),
          const SizedBox(height: 12),
          Obx(() => Row(
                children: [
                  Icon(Icons.account_balance_wallet,
                      size: 18, color: AppColors.lightprimary),
                  const SizedBox(width: 4),
                  Text(
                    "${controller.accounts.length} ${controller.accounts.length == 1 ? 'account' : 'accounts'}",
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.lightprimary,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
