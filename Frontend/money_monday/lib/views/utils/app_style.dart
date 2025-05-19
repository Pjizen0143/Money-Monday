import 'package:flutter/material.dart';
import 'package:money_monday/views/utils/widgets/app_style_container.dart';

const String mainFont = "OpenSans";

class AppTheme {
  static const Color orange = Color(0xffef8535);
  static const Color cream = Color(0xfffff4e1);

  static const TextStyle headingStyle = TextStyle(
    fontFamily: mainFont,
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 26,
  );

  static const TextStyle subheadingStyle = TextStyle(
    fontFamily: mainFont,
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 17,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontFamily: mainFont,
    color: Colors.black,
    fontWeight: FontWeight.normal,
    fontSize: 13,
  );

  static TextStyle emphasStyle = TextStyle();

  static TextStyle labelStyle = TextStyle();

  static TextStyle errorStyle = TextStyle();

  static TextStyle disabledStyle = TextStyle();

  static TextStyle notificationStyle = TextStyle();

  static TextStyle hintStyle = TextStyle(
    fontFamily: mainFont,
    color: Colors.black.withAlpha((115).round()),
    fontWeight: FontWeight.bold,
  );

  static const TextStyle inputStyle = TextStyle(
    fontFamily: mainFont,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: AppTheme.orange,
    foregroundColor: AppTheme.cream,
    textStyle: AppTheme.headingStyle,
  );
}

class AppWidgets {
  // static method ที่คืนค่าตัว AppStyleContainer พร้อมพารามิเตอร์ที่ส่งเข้าไป
  static Widget appContainer({
    double width = 691,
    double height = 676,
    double borderRadius = 31,
    Widget? child,
  }) {
    return AppStyleContainer(
      width: width,
      borderRadius: borderRadius,
      child: child,
    );
  }
}
