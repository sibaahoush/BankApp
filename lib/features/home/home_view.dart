import 'package:flutter/material.dart';
import 'package:se3/features/home/widgets/home_view_body.dart';

import '../../core/theme/app_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
 static const routename = "home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child:HomeViewBody()
      ));
  }
}