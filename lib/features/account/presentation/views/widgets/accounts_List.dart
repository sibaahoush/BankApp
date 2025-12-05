import 'package:flutter/widgets.dart';
import 'package:se3/features/account/presentation/views/account_details_view.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class AccountsList extends StatelessWidget {
  const AccountsList({super.key});

  @override
  Widget build(BuildContext context) {
    final accounts = [
      {"name": "Savings Account", "balance": "\$ 6,120.00", "type": "Savings"},
      {
        "name": "Checking Account",
        "balance": "\$ 2,850.50",
        "type": "Checking",
      },
      {"name": "Loan Account", "balance": "-\$ 4,200.00", "type": "Loan"},
      {
        "name": "Investment Account",
        "balance": "\$ 3,480.30",
        "type": "Investment",
      },
    ];

    return ListView.separated(
      itemCount: accounts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final acc = accounts[index];

        return GestureDetector(
          onTap: () {
            // الانتقال لصفحة تفاصيل الحساب
            Navigator.pushNamed(context, AccountDetailsView.routename);
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
                // اسم الحساب
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      acc["name"] as String,
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(acc["type"] as String, style: AppTextStyles.bodySmall),
                  ],
                ),

                // الرصيد
                Text(
                  acc["balance"] as String,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
