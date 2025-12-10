import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class TransactionFilters extends StatelessWidget {
  const TransactionFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _FilterChip(label: "All"),
          const SizedBox(width: 8),
          _FilterChip(label: "Income"),
          const SizedBox(width: 8),
          _FilterChip(label: "Outcome"),
          const SizedBox(width: 8),
          _FilterChip(label: "Pending"), // مهم بسبب Approve + Reject
          const Spacer(),
          const Icon(Icons.calendar_month_outlined),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;

  const _FilterChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: AppColors.form,
      label: Text(label, style: AppTextStyles.bodySmall),
    );
  }
}
