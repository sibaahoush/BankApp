import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:se3/features/auth/presentation/controllers/auth_controller.dart';
import 'package:se3/features/auth/presentation/views/sign_up_view.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/app_images.dart';
import 'SignInTextFieldSection.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  final _formKey = GlobalKey<FormBuilderState>();
  final AuthController _authController = Get.put(AuthController());

  void _handleSignIn() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;
      _authController.signIn(
        email: formData['email'],
        password: formData['password'],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ListView(
        children: [
          //  SizedBox(height: 48),
          Image.asset(AppImages.Login),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Welcome back!',
              style: AppTextStyles.headlineSmall.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          Text(
            'Lets Login for explore continues',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.border),
          ),
          SizedBox(height: 16),
          SignInTextFieldSection(formKey: _formKey),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                ' Forget password?',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          Obx(() => SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: _authController.isLoading.value ? null : _handleSignIn,
                  child: _authController.isLoading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('SignIn'),
                ),
              )),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'dont have account?',
                style: TextStyle(color: Colors.grey),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, SignUpView.routename),
                child: Text(
                  'SignUp',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
