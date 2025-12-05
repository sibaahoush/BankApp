import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';


class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back,",
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 4),
            Text(
              "Molham",
              style: AppTextStyles.headlineSmall,
            ),
          ],
        ),
        CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.lightprimary,
          child: Icon(
            Icons.person,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
