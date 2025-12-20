import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../account/presentation/controllers/account_controller.dart';

class TransactionFilters extends StatelessWidget {
  const TransactionFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountController controller = Get.find<AccountController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Obx(() => _FilterChip(
            label: "All",
            isSelected: controller.transactionFilter.value == 'all',
            onTap: () => controller.setTransactionFilter('all'),
          )),
          const SizedBox(width: 8),
          Obx(() => _FilterChip(
            label: "Income",
            isSelected: controller.transactionFilter.value == 'deposit',
            onTap: () => controller.setTransactionFilter('deposit'),
          )),
          const SizedBox(width: 8),
          Obx(() => _FilterChip(
            label: "Outcome",
            isSelected: controller.transactionFilter.value == 'withdraw',
            onTap: () => controller.setTransactionFilter('withdraw'),
          )),
          // const Spacer(),
          // const Icon(Icons.calendar_month_outlined),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        backgroundColor: isSelected ? AppColors.primary : AppColors.form,
        label: Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: isSelected ? Colors.white : AppColors.textDark,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
