import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:se3/features/account/presentation/controllers/account_controller.dart';
import 'package:se3/features/account/presentation/views/widgets/RecentTransactionsSection.dart';
import 'package:se3/features/account/presentation/views/widgets/accountActions.dart';
import 'package:se3/features/account/presentation/views/widgets/subAccountsSection.dart';

import 'accountSummaryCard.dart';

class AccountDetailsViewBody extends StatefulWidget {
  const AccountDetailsViewBody({super.key});

  @override
  State<AccountDetailsViewBody> createState() => _AccountDetailsViewBodyState();
}

class _AccountDetailsViewBodyState extends State<AccountDetailsViewBody> {
  final AccountController controller = Get.find<AccountController>();
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Only load once
    if (!_isInitialized) {
      _isInitialized = true;

      // Get account ID from navigation arguments
      final arguments = ModalRoute.of(context)?.settings.arguments;
      final accountId = arguments as int?;
      if (accountId != null) {
        controller.getAccountTree(accountId);
        controller.loadTransactionsForAccount(accountId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingDetails.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final account = controller.selectedAccount.value;
      if (account == null) {
        return const Center(
          child: Text('Account not found'),
        );
      }

      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccountSummaryCard(
              balance: account.balance,
              iban: account.number,
              status: account.status,
            ),
            const SizedBox(height: 20),
            AccountActions(accountId: account.id),
            const SizedBox(height: 24),
            SubAccountsSection(subAccounts: account.children),
            const SizedBox(height: 24),
            RecentTransactionsSection(accountId: account.id),
          ],
        ),
      );
    });
  }
}