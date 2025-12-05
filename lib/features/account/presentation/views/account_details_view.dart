import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'widgets/account_details_view_body.dart';

class AccountDetailsView extends StatelessWidget {
  const AccountDetailsView({super.key});
static const routename = "details";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child:AccountDetailsViewBody()
      ));
  }
}
 