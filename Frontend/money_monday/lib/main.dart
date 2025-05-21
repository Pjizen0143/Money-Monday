import 'package:flutter/material.dart';
import 'package:money_monday/routers/app_routes.dart';
import 'package:money_monday/viewmodels/auth_view_model.dart';
import 'package:money_monday/viewmodels/register_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        // คุณสามารถใส่ ViewModel ตัวอื่นเพิ่มได้ตรงนี้
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "My first app",
      theme: ThemeData(fontFamily: "OpenSans"),
      routerConfig: router,
    );
  }
}
