import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_monday/views/utils/app_style.dart';
import 'package:money_monday/views/utils/widgets/app_style_text_field.dart';
import 'package:provider/provider.dart';
import '../utils/widgets/logo.dart';
import '../../viewmodels/auth_view_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final loginBoxWidth = 676 * 0.63; // ขนาดความกว้างของ LoginBox

    return Scaffold(
      backgroundColor: AppTheme.orange,
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: -18,
              left:
                  (screenWidth - 250) /
                  2, // จัด LogoImage ให้อยู่ตรงกลาง (สมมติ width=250)
              child: const LogoAndLableImageCream(),
            ),
            Positioned(
              top: 200,
              left:
                  (screenWidth - loginBoxWidth) /
                  2, // คำนวณตำแหน่งกึ่งกลางแนวนอน
              child: const LoginBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginBox extends StatefulWidget {
  const LoginBox({super.key});

  @override
  State<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _usernameFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _loginFocus = FocusNode();

  bool rememberMe = false;
  bool hidePassword = true;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final authVM = context.read<AuthViewModel>(); // ดึง ViewModel

      await authVM.login(_usernameController.text, _passwordController.text);

      if (!mounted) return;

      if (authVM.loginResponse != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login Success!"),
            backgroundColor: Colors.green,
          ),
        );
      } else if (authVM.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${authVM.errorMessage!}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppWidgets.appContainer(
      width: 428,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Text(
              "Log In",
              style: AppTheme.headingStyle.copyWith(color: AppTheme.orange),
            ),
            const SizedBox(height: 15),
            UsernameTextField(
              controller: _usernameController,
              focusNode: _usernameFocus,
              nextFocusNode: _passwordFocus,
            ),
            const SizedBox(height: 15),
            PasswordTextField(
              focusNode: _passwordFocus,
              nextFocusNode: _loginFocus,
              controller: _passwordController,
              hide: hidePassword,
              onChanged: (hide) => setState(() => hidePassword = hide),
            ),
            const SizedBox(height: 10),
            RememberMeRow(
              value: rememberMe,
              onChanged: (value) => setState(() => rememberMe = value),
            ),
            const SizedBox(height: 20),

            // เชื่อม ViewModel ด้วย Consumer
            Consumer<AuthViewModel>(
              builder: (context, authVM, child) {
                return authVM.isLoading
                    ? const CircularProgressIndicator()
                    : LoginButton(onPressed: _login, focusNode: _loginFocus);
              },
            ),

            const SizedBox(height: 5),
            Text(
              "or",
              style: AppTheme.bodyStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            GoogleSignInButton(),
            const SizedBox(height: 30),
            const RegisterPrompt(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class UsernameTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  const UsernameTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: AppStyleTextFormField(
        hintText: "username",
        maxLines: 1,
        validatorText: "Enter username",
        controller: controller,
        focusNode: focusNode,
        onFieldSubmitted:
            (_) => FocusScope.of(context).requestFocus(nextFocusNode),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final bool hide;
  final ValueChanged<bool> onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  const PasswordTextField({
    super.key,
    required this.onChanged,
    required this.hide,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: AppStyleTextFormField(
        focusNode: focusNode,
        hintText: "Password",
        maxLines: 1,
        obscureText: hide,
        controller: controller,
        validatorText: "Enter password",
        suffixIcon: GestureDetector(
          onTap: () => onChanged(!hide),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                hide ? CupertinoIcons.lock_fill : CupertinoIcons.lock_open_fill,
                color: Colors.black.withAlpha(115),
                size: 20,
              ),
            ),
          ),
        ),
        onFieldSubmitted:
            (_) => FocusScope.of(context).requestFocus(nextFocusNode),
      ),
    );
  }
}

class RememberMeRow extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const RememberMeRow({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // แทนที่ Checkbox ด้วย GestureDetector ที่มี Icon
              GestureDetector(
                onTap:
                    () => onChanged(
                      !value,
                    ), // เมื่อแตะ ให้สลับค่า value และเรียก onChanged
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(
                      // แสดงไอคอนหัวใจทึบถ้า value เป็น true, ไม่งั้นแสดงหัวใจโปร่ง
                      value
                          ? CupertinoIcons.check_mark_circled_solid
                          : Icons.circle_outlined,
                      size: 24, // กำหนดขนาดเท่าเดิม
                      color: AppTheme.orange,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              Text(
                // TODO: Remember me
                "Remember me",
                style: AppTheme.bodyStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withAlpha(200),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              // TODO: Forgot password
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                "Forgot password",
                style: AppTheme.bodyStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withAlpha(200),
                  decoration: TextDecoration.underline,
                  decorationThickness: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final FocusNode? focusNode;

  const LoginButton({super.key, required this.onPressed, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return AppWidgets.appPrimaryButton(
      focusNode: focusNode,
      onPressed: onPressed,
      text: "Log in",
      width: 300,
      height: 45,
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 300,
      child: OutlinedButton.icon(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white, // สีพื้นหลังปุ่ม
          foregroundColor: Colors.black87, // สีข้อความและไอคอน
          side: BorderSide(
            color: CupertinoColors.activeBlue,
            width: 1.0,
          ), // เส้นขอบปุ่ม
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // ทำให้ปุ่มมีมุมโค้งมน
          ),
        ),
        icon: Image.asset(
          'assets/images/google-logo.png',
          height: 30,
          width: 30,
        ),
        label: Text(
          "Sign in with Google",
          style: AppTheme.subheadingStyle.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}

class RegisterPrompt extends StatelessWidget {
  const RegisterPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?   ",
          style: AppTheme.bodyStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black.withAlpha(200),
          ),
        ),
        GestureDetector(
          onTap: () => context.push('/register'),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Text(
              "Register",
              style: AppTheme.bodyStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.orange.withAlpha(200),
                decoration: TextDecoration.underline,
                decorationThickness: 2.0,
                decorationColor: AppTheme.orange,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
