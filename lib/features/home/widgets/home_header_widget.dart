import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:se3/features/auth/presentation/controllers/auth_controller.dart';
import 'package:se3/features/home/controllers/home_controller.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  void _showLogoutMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.lightprimary,
              child: Icon(
                Icons.person,
                size: 40,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              final controller = Get.find<HomeController>();
              return Text(
                controller.userName.value,
                style: AppTextStyles.headlineSmall,
              );
            }),
            const SizedBox(height: 24),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text(
                'Logout',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _showLogoutConfirmation(context);
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.border),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              final authController = Get.put(AuthController());
              authController.logout();
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

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
            Obx(() => Text(
                  controller.userName.value,
                  style: AppTextStyles.headlineSmall,
                )),
          ],
        ),
        GestureDetector(
          onTap: () => _showLogoutMenu(context),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.lightprimary,
            child: Icon(
              Icons.person,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
