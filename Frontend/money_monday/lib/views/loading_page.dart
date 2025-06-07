import 'package:flutter/material.dart';
import 'package:money_monday/views/utils/app_style.dart';
import 'package:money_monday/views/utils/widgets/logo.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: Text(AppTheme.appVersion, style: AppTheme.bodyStyle),
        backgroundColor: AppTheme.cream,
        toolbarHeight: 20,
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              left: (screenWidth - 350) / 2,
              top: (screenHeight - 450) / 2,
              child: const LogoAndLableImageOrange(height: 350, width: 350),
            ),
            Positioned(
              left: (screenWidth - 60) / 2,
              top: screenHeight / 2 + 80,
              child: const SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
