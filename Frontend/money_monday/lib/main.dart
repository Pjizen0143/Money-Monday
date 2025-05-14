import 'package:flutter/material.dart';
import 'package:money_monday/views/auth/login_page.dart';
import 'package:money_monday/views/utils/app_style.dart';

final GlobalKey<NavigatorState> _navigatorkey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // กำหนด _navigatorkey ให้กับคุณสมบัติ navigatorKey ของ MaterialApp
      navigatorKey: _navigatorkey,
      title: "My first app",
      theme: ThemeData(fontFamily: "OpenSans"),
      home: Scaffold(body: LogIn(), backgroundColor: AppTheme.orange),
    );
  }
}
