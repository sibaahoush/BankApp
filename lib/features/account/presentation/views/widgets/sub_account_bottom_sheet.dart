import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

void showCreateSubAccountBottomSheet(BuildContext context) {
  final nameController = TextEditingController();
  final balanceController = TextEditingController(); // حقل الرصيد
  String? selectedType;

  final types = ["Child account", "Business account", "Savings sub-account"];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: AppColors.cardLight,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.border.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Text("Create sub-account", style: AppTextStyles.titleMedium),
                const SizedBox(height: 12),

                // اسم الحساب الفرعي
                Text("Sub-account name", style: AppTextStyles.labelSmall),
                const SizedBox(height: 4),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "e.g. Travel savings",
                    hintStyle: AppTextStyles.bodySmall,
                    filled: true,
                    fillColor: AppColors.form,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // الرصيد الابتدائي
                Text("Initial balance", style: AppTextStyles.labelSmall),
                const SizedBox(height: 4),
                TextField(
                  controller: balanceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    hintText: "e.g. 250.00",
                    hintStyle: AppTextStyles.bodySmall,
                    prefixText: "\$ ",
                    prefixStyle: AppTextStyles.bodySmall,
                    filled: true,
                    fillColor: AppColors.form,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // نوع الحساب الفرعي
                Text("Type", style: AppTextStyles.labelSmall),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.form,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedType,
                      hint: Text("Select type", style: AppTextStyles.bodySmall),
                      isExpanded: true,
                      items:
                          types
                              .map(
                                (t) => DropdownMenuItem(
                                  value: t,
                                  child: Text(
                                    t,
                                    style: AppTextStyles.bodySmall,
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedType = value;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final name = nameController.text.trim();
                      final balanceText = balanceController.text.trim();

                      if (name.isEmpty ||
                          balanceText.isEmpty ||
                          selectedType == null) {
                        return;
                      }

                      final balance = double.tryParse(balanceText) ?? 0;

                      Navigator.pop(context);
                    },
                    child: Text(
                      "Create",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
