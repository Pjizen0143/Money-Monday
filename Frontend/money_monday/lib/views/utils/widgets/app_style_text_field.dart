import 'package:flutter/material.dart';
import 'package:money_monday/views/utils/app_style.dart';

class AppStyleTextFormField extends StatefulWidget {
  final int? maxLength;
  final int? maxLines;
  final bool obscureText;
  final String hintText;
  final String? validatorText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  const AppStyleTextFormField({
    super.key,
    this.maxLength,
    this.maxLines,
    required this.hintText,
    this.validatorText,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  State<AppStyleTextFormField> createState() => _AppStyleTextFormFieldState();
}

class _AppStyleTextFormFieldState extends State<AppStyleTextFormField> {
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      validator: (value) {
        if (value!.isEmpty) return widget.validatorText;
        return null;
      },
    );
  }
}
