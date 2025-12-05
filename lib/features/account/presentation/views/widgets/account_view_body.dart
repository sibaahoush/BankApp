import 'package:flutter/material.dart';

import 'accounts_List.dart';
import 'create_sub_account.dart';

class AccountViewBody extends StatelessWidget {
  const AccountViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: const [
            Expanded(child: AccountsList()),
            SizedBox(height: 10),
            CreateSubAccountButton(),
          ],
        ));
  }
}