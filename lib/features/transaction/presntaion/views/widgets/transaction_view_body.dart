import 'package:flutter/material.dart';

import 'BottomButtons.dart';
import 'TransactionFilters.dart';
import 'TransactionList.dart';

class TransactionViewBody extends StatelessWidget {
  const TransactionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const TransactionFilters(),
          const SizedBox(height: 10),
          const Expanded(child: TransactionList()),
          const SizedBox(height: 10),
          const BottomButtons(),
        ],
      
    );
  }
}