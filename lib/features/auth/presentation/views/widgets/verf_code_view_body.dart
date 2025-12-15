import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:se3/features/auth/presentation/controllers/auth_controller.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class VerfCodeViewBody extends StatefulWidget {
  const VerfCodeViewBody({super.key});

  @override
  State<VerfCodeViewBody> createState() => _VerfCodeViewBodyState();
}

class _VerfCodeViewBodyState extends State<VerfCodeViewBody> {
  final AuthController _authController = Get.find<AuthController>();
  String _verificationCode = '';

  void _handleVerify() {
    if (_verificationCode.length == 6) {
      _authController.verifyCode(code: _verificationCode);
    } else {
      Get.snackbar(
        'Error',
        'Please enter the complete verification code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      children: [
        const SizedBox(height: 20),
        const Text(
          'Enter verification code',
          style: AppTextStyles.headlineSmall,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Obx(() => Text(
              'A verification code has been sent to ${_authController.verificationEmail.value}',
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            )),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: OtpTextField(
            borderRadius: BorderRadius.circular(8),
            fieldWidth: 50,
            numberOfFields: 6,
            borderColor: const Color.fromARGB(255, 52, 78, 62),
            focusedBorderColor: AppColors.primary,
            showFieldAsBox: true,
            onCodeChanged: (String code) {
              _verificationCode = code;
            },
            onSubmit: (String verificationCode) {
              _verificationCode = verificationCode;
              _handleVerify();
            },
          ),
        ),
        SizedBox(height: 10),
        Text(
          'We send it to your email you can chack to inbox.',
          style: AppTextStyles.bodyMedium,
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              'You did not receive any code? ',
              style: AppTextStyles.bodyMedium,
            ),
            GestureDetector(
              onTap: () => _authController.resendVerificationCode(),
              child: Text(
                'Send again',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Obx(() => SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: _authController.isLoading.value ? null : _handleVerify,
                child: _authController.isLoading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('verify'),
              ),
            )),
      ],
    );
  }
}
