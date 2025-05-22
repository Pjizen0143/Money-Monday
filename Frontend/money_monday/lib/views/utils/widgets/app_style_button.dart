import 'package:flutter/material.dart';
import 'package:money_monday/views/utils/app_style.dart';

class AppStylePrimaryButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String? text;
  final FocusNode? focusNode;
  final VoidCallback onPressed;

  const AppStylePrimaryButton({
    super.key,
    this.height,
    this.width,
    this.text,
    this.focusNode,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        focusNode: focusNode,
        onPressed: onPressed,
        style: AppTheme.primaryButton,
        child: Text(
          "$text",
          style: AppTheme.subheadingStyle.copyWith(color: AppTheme.cream),
        ),
      ),
    );
  }
}
