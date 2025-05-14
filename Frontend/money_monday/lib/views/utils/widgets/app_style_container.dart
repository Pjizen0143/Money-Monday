import 'package:flutter/material.dart';
import 'package:money_monday/views/utils/app_style.dart';

class AppStyleContainer extends StatelessWidget {
  final double width;
  final double borderRadius;
  final Widget? child; // เพิ่ม child เพื่อรองรับ widget ลูก

  const AppStyleContainer({
    super.key,
    this.width = 691,
    this.borderRadius = 31,
    this.child, // ให้ child เป็นพารามิเตอร์
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.63,
      decoration: BoxDecoration(
        color: AppTheme.cream, // ใช้สีจาก AppTheme
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child, // ใช้ child ที่ถูกส่งมา
    );
  }
}
