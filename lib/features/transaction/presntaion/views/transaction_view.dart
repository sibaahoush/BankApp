import 'package:flutter/material.dart';
import 'package:se3/features/transaction/presntaion/views/widgets/transaction_view_body.dart';

import '../../../../core/theme/app_colors.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child:TransactionViewBody()
      ));
  }
}
 