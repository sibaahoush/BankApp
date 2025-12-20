import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({
    super.key,
    required this.onTransfer,
    required this.onDeposit,
    required this.onWithdraw,
    required this.onScanOrPay,
  });

  final VoidCallback onTransfer;
  final VoidCallback onDeposit;
  final VoidCallback onWithdraw;
  final VoidCallback onScanOrPay;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick actions",
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _QuickActionItem(
              icon: Icons.send_rounded,
              label: "Transfer",
              onTap: onTransfer,
            ),
            _QuickActionItem(
              icon: Icons.add_circle_rounded,
              label: "Deposit",
              onTap: onDeposit,
            ),
            _QuickActionItem(
              icon: Icons.money_off_csred_rounded,
              label: "Withdraw",
              onTap: onWithdraw,
            ),
            // _QuickActionItem(
            //   icon: Icons.qr_code_scanner_rounded,
            //   label: "Scan",
            //   onTap: onScanOrPay,
            // ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardLight,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}
