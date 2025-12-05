import 'package:flutter/material.dart';

import 'widgets/verf_code_view_body.dart';

class VerfCodeView extends StatelessWidget {
  const VerfCodeView({super.key});
  static const routename = "vrfCode";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('vrfCode')),
      body: VerfCodeViewBody(),
    );
  }
}
