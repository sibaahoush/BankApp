import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../account/presentation/controllers/account_controller.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final AccountController _controller = Get.find<AccountController>();

  @override
  void initState() {
    super.initState();
    _controller.loadAllTransactions();
  }

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
    return Obx(() {
      if (_controller.isLoadingTransactions.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final filteredTransactions = _controller.filteredTransactions;

      if (filteredTransactions.isEmpty) {
        return Center(
          child: Text(
            'No transactions found',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textGrey,
            ),
          ),
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filteredTransactions.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final transaction = filteredTransactions[i];
          final isDeposit = transaction.isDeposit;

          Color color = isDeposit ? AppColors.success : AppColors.error;

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
                  isDeposit ? Icons.arrow_downward : Icons.arrow_upward,
                  color: color,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.type.toUpperCase(),
                        style: AppTextStyles.bodyMedium,
                      ),
                      Text(
                        '${transaction.status} • ${_formatDate(transaction.createdAt)}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textGrey,
                        ),
                      ),
                      if (transaction.description != null)
                        Text(
                          transaction.description!,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textGrey,
                            fontSize: 11,
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  '${isDeposit ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
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
    });
  }
}
