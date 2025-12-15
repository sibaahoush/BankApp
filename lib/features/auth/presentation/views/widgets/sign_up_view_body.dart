import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:se3/features/auth/presentation/controllers/auth_controller.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/app_images.dart';
import 'SignUpTextFieldSection.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final _formKey = GlobalKey<FormBuilderState>();
  final AuthController _authController = Get.put(AuthController());

  void _handleSignUp() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;
      _authController.signUp(
        name: formData['name'],
        phone: formData[' Phone number'],
        email: formData['email'],
        password: formData['password'],
        passwordConfirmation: formData['password_confirmation'],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ListView(
        children: [
          Image.asset(AppImages.signup, height: 200),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Lets Get Started',
              style: AppTextStyles.headlineSmall.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          Text(
            'creat an account to get all featurs',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.border),
          ),
          SizedBox(height: 16),
          SignUpTextFieldSection(formKey: _formKey),
          Obx(() => SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: _authController.isLoading.value ? null : _handleSignUp,
                  child: _authController.isLoading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('SignUp'),
                ),
              )),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Have an account?',
                style: TextStyle(color: Colors.grey),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  'SignIn',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
