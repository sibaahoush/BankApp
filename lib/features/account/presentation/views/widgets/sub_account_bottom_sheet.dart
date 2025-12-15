import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:se3/core/controllers/app_data_controller.dart';
import 'package:se3/features/account/presentation/controllers/account_controller.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

void showCreateSubAccountBottomSheet(BuildContext context, {int? parentAccountId}) {
  final balanceController = TextEditingController();
  final AppDataController appDataController = Get.find<AppDataController>();
  final AccountController accountController = Get.find<AccountController>();

  int? selectedTypeId;

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

                Text(
                  parentAccountId != null ? "Create Sub-Account" : "Create New Account",
                  style: AppTextStyles.titleMedium,
                ),
                const SizedBox(height: 12),

                // Account Type
                Text("Account Type", style: AppTextStyles.labelSmall),
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
                    child: DropdownButton<int>(
                      value: selectedTypeId,
                      hint: Text("Select account type", style: AppTextStyles.bodySmall),
                      isExpanded: true,
                      items: appDataController.accountTypes
                          .map(
                            (type) => DropdownMenuItem(
                              value: type.id,
                              child: Text(
                                type.name.toUpperCase(),
                                style: AppTextStyles.bodySmall,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTypeId = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Initial Balance
                Text("Initial Balance", style: AppTextStyles.labelSmall),
                const SizedBox(height: 4),
                TextField(
                  controller: balanceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    hintText: "e.g. 100.00",
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

                const SizedBox(height: 20),
                Obx(() => SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: accountController.isCreating.value
                            ? null
                            : () {
                                final balanceText = balanceController.text.trim();

                                if (balanceText.isEmpty || selectedTypeId == null) {
                                  Get.snackbar(
                                    'Error',
                                    'Please fill all fields',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                  return;
                                }

                                final balance = double.tryParse(balanceText);
                                if (balance == null || balance < 0) {
                                  Get.snackbar(
                                    'Error',
                                    'Please enter a valid balance',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                  return;
                                }

                                accountController.createAccount(
                                  typeId: selectedTypeId!,
                                  balance: balance,
                                  accountRelatedId: parentAccountId,
                                );
                              },
                        child: accountController.isCreating.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Text(
                                "Create Account",
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    )),
              ],
            );
          },
        ),
      );
    },
  );
}
