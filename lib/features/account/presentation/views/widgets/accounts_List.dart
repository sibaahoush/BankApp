import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:se3/features/account/presentation/controllers/account_controller.dart';
import 'package:se3/features/account/presentation/views/account_details_view.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class AccountsList extends StatelessWidget {
  const AccountsList({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountController controller = Get.find<AccountController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (controller.accounts.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                size: 80,
                color: AppColors.border.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No accounts yet',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.border,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Create your first account below',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.border,
                ),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: controller.refresh,
        child: ListView.separated(
          itemCount: controller.accounts.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final account = controller.accounts[index];

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AccountDetailsView.routename,
                  arguments: account.id,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardLight,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border.withOpacity(0.3)),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$ ${account.balance.toStringAsFixed(2)}",
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: account.status.toLowerCase() == 'active'
                                ? Colors.green.withOpacity(0.1)
                                : Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            account.status.toUpperCase(),
                            style: AppTextStyles.bodySmall.copyWith(
                              color: account.status.toLowerCase() == 'active'
                                  ? Colors.green
                                  : AppColors.border,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
