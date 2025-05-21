import 'package:flutter/material.dart';
import 'package:money_monday/views/utils/app_style.dart';

class AppStyleTextFormField extends StatelessWidget {
  final int? maxLength;
  final int? maxLines;
  final bool obscureText;
  final String hintText;
  final String? validatorText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;

  const AppStyleTextFormField({
    super.key,
    this.maxLength,
    this.maxLines,
    required this.hintText,
    this.validatorText,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      maxLength: maxLength,
      maxLines: maxLines,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      style: AppTheme.inputStyle,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: AppTheme.hintStyle,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.orange),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        suffixIcon: suffixIcon,
      ),
      validator: (value) {
        if (value!.isEmpty) return validatorText;
        return null;
      },
    );
  }
}
