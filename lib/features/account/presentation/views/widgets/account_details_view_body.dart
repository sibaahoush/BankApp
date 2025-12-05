import 'package:flutter/material.dart';
import 'package:se3/features/account/presentation/views/widgets/RecentTransactionsSection.dart';
import 'package:se3/features/account/presentation/views/widgets/accountActions.dart';
import 'package:se3/features/account/presentation/views/widgets/subAccountsSection.dart';

import 'accountSummaryCard.dart';

class AccountDetailsViewBody extends StatelessWidget {
  const AccountDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final double balance = 6120.00;
    final String iban = "AE34 1020 0000 3456 7890";
    final String status = "Active"; // Active / Frozen / Closed
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccountSummaryCard(
              balance: balance,
              iban: iban,
              status: status,
            ),
            const SizedBox(height: 20),
            const AccountActions(),
            const SizedBox(height: 24),
            const SubAccountsSection(),
            const SizedBox(height: 24),
            const RecentTransactionsSection(),
          ],
        ),
      
    );
  }
}