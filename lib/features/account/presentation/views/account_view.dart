import 'package:flutter/material.dart';
import 'package:se3/features/account/presentation/views/widgets/account_view_body.dart';

import '../../../../core/theme/app_colors.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child:AccountViewBody()
      ));
  }
}
 