import 'package:flutter/material.dart';
import 'package:se3/core/utils/show_err_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> callNumber(BuildContext context, String phoneNumber) async {
  final uri = Uri(scheme: 'tel', path: phoneNumber);
  final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!ok && context.mounted) {
    showerrorDialog(
      context: context,
      title: "فشل الاتصال",
      description: "تعذر الاتصال بالرقم",
    );
  }
}
