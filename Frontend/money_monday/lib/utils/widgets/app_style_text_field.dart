import 'package:flutter/material.dart';
import 'package:money_monday/utils/app_style.dart';

class AppStyleTextField extends StatefulWidget {
  final int? maxLength;
  final int? maxLines;
  final bool obscureText;
  final String hintText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  const AppStyleTextField({
    super.key,
    this.maxLength,
    this.maxLines,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  State<AppStyleTextField> createState() => _AppStyleTextFieldState();
}

class _AppStyleTextFieldState extends State<AppStyleTextField> {
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText,
      focusNode: _focusNode,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      controller: widget.controller,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      style: AppTheme.inputStyle,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        hintStyle: AppTheme.hintStyle,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.orange),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}
