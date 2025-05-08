import 'package:flutter/material.dart';
import 'package:money_monday/screen/opening/login_page.dart';
import 'package:money_monday/utils/app_style.dart';

void main() {
  MaterialApp app = MaterialApp(
    title: "My frist app",
    theme: ThemeData(fontFamily: "OpenSans"),
    home: Scaffold(body: LogIn(), backgroundColor: AppTheme.orange),
  );
  runApp(app);
}
