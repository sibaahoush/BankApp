
import 'package:flutter/material.dart';
import 'widgets/sign_up_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static const routename = "signup";

  @override
  Widget build(BuildContext context) {
    return Scaffold 
    (
      backgroundColor: Colors.white,
      body: SignUpViewBody()
      
    );
  }
}
