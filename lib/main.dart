import 'package:flutter/material.dart';
import 'package:se3/core/theme/App_themes.dart';

import 'core/routing/routing.dart';
import 'features/auth/presentation/views/sign_in_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BankManagmentApp());
}

class BankManagmentApp extends StatelessWidget {
  const BankManagmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // home: Text('data'),
      onGenerateRoute: onGenerateRoute,
      initialRoute: SignInView.routename,
    );
  }
}
