import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:se3/core/utils/show_question_dialog.dart';
import 'package:se3/features/account/presentation/controllers/account_controller.dart';
import 'package:se3/features/transaction/presntaion/views/widgets/withdraw_transaction_screen.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import 'showEditAccountBottomSheet.dart';
import 'sub_account_bottom_sheet.dart';

class AccountActions extends StatelessWidget {
  final int accountId;

  const AccountActions({super.key, required this.accountId});

  @override
  Widget build(BuildContext context) {
    final AccountController accountController = Get.find<AccountController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Actions", style: AppTextStyles.titleMedium),
        const SizedBox(height: 5),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(color: AppColors.primary),
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                WithdrawTransactionScreen.routename,
              );
            },
            child: Text("Withdraw to card", style: AppTextStyles.bodyMedium),
          ),
        ),
        const SizedBox(height: 0),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.add_rounded, color: Colors.white),
            label: Text(
              "Add sub-account",
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
            ),
            onPressed: () {
              showCreateSubAccountBottomSheet(context, parentAccountId: accountId);
            },
          ),
        ),
        const SizedBox(height: 0),
        Row(
          children: [
            // Expanded(
            //   child: _OutlinedActionButton(
            //     label: "Freeze account",
            //     color: Colors.blue,
            //     icon: Icons.ac_unit_rounded,
            //     onPressed: () {
            //       showQuestionDialog(
            //         context: context,
            //         title: "Freeze account",
            //         description:
            //             "Are you sure you want to freeze this account?",
            //         btnOkOnPress: () {},
            //       );
            //       // TODO: Freeze logic
            //     },
            //   ),
            // ),
            // const SizedBox(width: 10),
            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.all(4.0),
            //     child: _OutlinedActionButton(
            //       label: "Edit account",
            //       color: AppColors.warning,
            //       icon: Icons.edit,
            //       onPressed: () {
            //         showEditAccountBottomSheet(
            //           context,
            //           initialName: "Savings Account",
            //           initialStatus: "Active",
            //           initialDescription: "My main savings account",
            //         );
            //       },
            //     ),
            //   ),
            // ),
            // const SizedBox(width: 10),
            Expanded(
              child: _OutlinedActionButton(
                label: "Close account",
                color: AppColors.error,
                icon: Icons.close_rounded,
                onPressed: () {
                  showQuestionDialog(
                    context: context,
                    title: "Close account",
                    description: "Are you sure you want to close this account?",
                    btnOkOnPress: () {
                      accountController.closeAccount(accountId);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OutlinedActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const _OutlinedActionButton({
    required this.label,
    required this.color,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color.withOpacity(0.6)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Icon(icon, size: 18, color: color),
      label: Text(
        label,
        textAlign: TextAlign.center,
        style: AppTextStyles.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
