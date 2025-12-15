import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:se3/core/controllers/app_data_controller.dart';
import 'package:se3/core/services/local_storage_service.dart';
import 'package:se3/features/account/presentation/controllers/account_controller.dart';
import 'package:se3/features/ai/presentation/controllers/ai_bot_controller.dart';
import 'package:se3/features/auth/presentation/views/sign_in_view.dart';
import 'package:se3/features/main/presntation/views/main_view.dart';
import 'package:se3/features/ticket/presentation/controllers/ticket_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const routename = "splash";

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppDataController _appDataController = Get.put(AppDataController());
  final AccountController _accountController = Get.put(AccountController());
  final TicketController _ticketController = Get.put(TicketController());
  final AiBotController _aiBotController = Get.put(AiBotController());

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Load general data
      await _appDataController.loadAllData();

      // Check if user is logged in
      final token = await LocalStorageService.getItem(LocalStorageKeys.token);
      final isLoggedIn = token != null && token.isNotEmpty;

      // Add a small delay for better UX
      await Future.delayed(const Duration(seconds: 1));

      // Navigate to appropriate screen
      if (isLoggedIn) {
        Get.offAllNamed('main');
      } else {
        Get.offAllNamed(SignInView.routename);
      }
    } catch (e) {
      // On error, navigate to sign in
      Get.offAllNamed(SignInView.routename);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // You can replace this with your app logo
            Icon(
              Icons.account_balance,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 24),
            Text(
              'Bank Management',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 48),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
