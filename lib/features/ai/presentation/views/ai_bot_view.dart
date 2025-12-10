import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'widgets/ai_bot_view_body.dart';

class ChatbotView extends StatelessWidget {
  const ChatbotView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child:ChatbotViewBody()
      ));
  }
}