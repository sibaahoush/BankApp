import 'package:flutter/material.dart';
import 'package:se3/features/home/widgets/balance_card.dart';
import 'package:se3/features/transaction/presntaion/views/widgets/withdraw_transaction_screen.dart';

import '../../transaction/presntaion/views/widgets/NewTransaction.dart';
import 'accounts_Section.dart';
import 'home_header_widget.dart';
import 'quick_actions.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(),
          SizedBox(height: 20),
          BalanceCard(),
          SizedBox(height: 20),
          QuickActions(
            onTransfer: () {
              Navigator.pushNamed(
                context,
                NewTransactionScreen.routename,
                arguments: {"initialType": "transfer"},
              );
            },
            onDeposit: () {
              Navigator.pushNamed(
                context,
                NewTransactionScreen.routename,
                arguments: {"initialType": "deposit"},
              );
            },
            onWithdraw: () {
              Navigator.pushNamed(context, WithdrawTransactionScreen.routename);
            },
            onScanOrPay: () {
              // showPayBottomSheet(context);  // أو شاشة QR
            },
          ),

          SizedBox(height: 24),
          AccountsSection(),
          SizedBox(height: 24),
          //   RecentTransactionsSection(),
        ],
      ),
    );
  }
}
