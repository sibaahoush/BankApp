import 'package:flutter/material.dart';

abstract class AppColors {
  // اللون الأساسي (ثقة / مال)
  static const Color primary = Color(0xff2f5f61);
  static const Color lightprimary = Color(0xfff0faf9);   

  // للخلفيات
  static const Color background = Color(0xFFF9FAFB); // رمادي فاتح جداً
  static const Color form = Color(0xFFF3F4F6); // رمادي فاتح للفورم
  static const Color border = Colors.grey;
  // البطاقات
  static const Color cardLight = Colors.white;
  static const Color cardDark = Color(0xFF1E293B);

  // النصوص
  static const Color textDark = Color(0xFF111827); // أسود غامق
  static const Color textGrey = Color(0xFF6B7280); // رمادي للنصوص الثانوية

  // الحالات
  static const Color success = Color(0xFF22C55E); // أخضر فاتح ()
  static const Color warning = Color(0xFFFACC15); // أصفر (تنبيه)
  static const Color error = Color(0xFFDC2626); // أحمر ( )
}
