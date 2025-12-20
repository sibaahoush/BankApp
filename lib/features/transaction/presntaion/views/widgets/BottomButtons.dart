import 'package:flutter/material.dart';
import 'package:se3/features/transaction/presntaion/views/widgets/NewTransaction.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import 'NewScheduledPayment.dart';
import 'pay_bottom_sheet.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [

          // زر New Transaction
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, NewTransactionScreen.routename);

                // لاحقاً → افتح
              },
              child: Text(
                "New transaction",
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 0),

          // زر Scheduled Payments
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(color: AppColors.border.withOpacity(0.7)),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  NewScheduledPaymentScreen.routename,
                );
                // افتح ScheduledPaymentsScreen
              },
              child: Text(
                "Scheduled payments",
                style: AppTextStyles.bodyMedium,
              ),
            ),
          ),
          // جوّا _BottomButtons مثلاً:
SizedBox(
  width: double.infinity,
  child: 
   ElevatedButton(
     style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
    onPressed: () {
      showPayBottomSheet(context);
    },
    child: const Text("Pay with card"),
  ),
),

        ],
      ),
    );
  }
}
