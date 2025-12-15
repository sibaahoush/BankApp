import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../controllers/account_controller.dart';

class RecentTransactionsSection extends StatelessWidget {
  final int accountId;

  const RecentTransactionsSection({
    super.key,
    required this.accountId,
  });

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final transactionDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (transactionDate == today) {
      return 'Today';
    } else if (transactionDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM d, yyyy').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AccountController controller = Get.find<AccountController>();

    return Obx(() {
      if (controller.isLoadingTransactions.value) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent transactions",
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 10),
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        );
      }

      final accountTransactions = controller.transactions;

      if (accountTransactions.isEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent transactions",
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'No transactions yet',
                style: AppTextStyles.bodySmall,
              ),
            ),
          ],
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent transactions",
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: 10),
          Column(
            children: accountTransactions.map((transaction) {
              final isDeposit = transaction.isDeposit;
              final displayAmount = '\$${transaction.amount.toStringAsFixed(2)}';

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.form,
                    child: Icon(
                      isDeposit
                          ? Icons.arrow_downward_rounded
                          : Icons.arrow_upward_rounded,
                      color: isDeposit ? AppColors.success : AppColors.error,
                      size: 18,
                    ),
                  ),
                  title: Text(
                    transaction.type.toUpperCase(),
                    style: AppTextStyles.bodyMedium,
                  ),
                  subtitle: Text(
                    "${transaction.description ?? transaction.status} • ${_formatDate(transaction.createdAt)}",
                    style: AppTextStyles.bodySmall,
                  ),
                  trailing: Text(
                    '${isDeposit ? '+' : '-'}$displayAmount',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isDeposit ? AppColors.success : AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      );
    });
  }
}
