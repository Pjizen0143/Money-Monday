import 'package:flutter/material.dart';

class LogoAndLableImage extends StatelessWidget {
  final double width;
  final double height;

  const LogoAndLableImage({
    super.key,
    this.width = 250, // default value ถ้าไม่ส่งมาก็ใช้ค่านี้
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        'assets/images/Logo&text(cream).png',
        fit: BoxFit.contain,
      ),
    );
  }
}
