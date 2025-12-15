import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:se3/core/theme/App_themes.dart';
import 'package:se3/features/splash/splash_view.dart';

import 'core/routing/routing.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BankManagmentApp());
}

class BankManagmentApp extends StatelessWidget {
  const BankManagmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routename,
    );
  }
}
