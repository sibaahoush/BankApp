import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class VerfCodeViewBody extends StatelessWidget {
  const VerfCodeViewBody({super.key});

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
        Text(
          'A verification code has been sent to your email',
          style: AppTextStyles.bodyMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: OtpTextField(
            borderRadius: BorderRadius.circular(8),
            fieldWidth: 40,
            numberOfFields: 5,
            borderColor: const Color.fromARGB(255, 52, 78, 62),
            focusedBorderColor: AppColors.primary,
            showFieldAsBox: true,

            onCodeChanged: (String code) {},

            onSubmit: (String verificationCode) {
              //   controller.goTosucessSignUp( verificationCode);
            }, // end onSubmit
          ),
        ),

        SizedBox(height: 10),
        Text(
          'We send it to your email you can chack to inbox.',
          style: AppTextStyles.bodyMedium,
          // textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              'You did not receive any code? ',
              style: AppTextStyles.bodyMedium,
              // textAlign: TextAlign.center,
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Send again',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                // textAlign: TextAlign.center,
              ),
            ),
          ],
        ),

        SizedBox(height: 20),
        SizedBox(
          width: 200,
          child: ElevatedButton(onPressed: () {}, child: const Text('verify')),
        ),
      ],
    );
  }
}
