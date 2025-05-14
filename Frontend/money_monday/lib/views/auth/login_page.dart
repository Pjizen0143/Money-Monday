import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_monday/views/loading.dart';
import 'package:money_monday/views/utils/app_style.dart';
import 'package:money_monday/views/utils/widgets/app_style_text_field.dart';
import '../utils/widgets/logo.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final loginBoxWidth = 676 * 0.63; // ขนาดความกว้างของ LoginBox

    return Center(
      child: Stack(
        children: [
          Positioned(
            top: -18,
            left:
                (screenWidth - 250) /
                2, // จัด LogoImage ให้อยู่ตรงกลาง (สมมติ width=250)
            child: const LogoAndLableImage(),
          ),
          Positioned(
            top: 200, // ระยะห่างที่คุณพอใจ
            left:
                (screenWidth - loginBoxWidth) / 2, // คำนวณตำแหน่งกึ่งกลางแนวนอน
            child: const LoginBox(),
          ),
        ],
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

  bool rememberMe = false;
  bool hidePassword = true;

  void _performLogin() {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      if (username == 'admin1234' && password == 'admin1234') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hello admin'), backgroundColor: Colors.blue),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid username or password'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppWidgets.appContainer(
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
            UsernameTextField(controller: _usernameController),
            const SizedBox(height: 15),
            PasswordTextField(
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
            LoginButton(onPressed: _performLogin),
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
  const UsernameTextField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: AppStyleTextFormField(
        hintText: "username",
        maxLines: 1,
        validatorText: "Enter username",
        controller: controller,
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final bool hide;
  final ValueChanged<bool> onChanged;
  final TextEditingController? controller;

  const PasswordTextField({
    super.key,
    required this.onChanged,
    required this.hide,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: AppStyleTextFormField(
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
                      color:
                          value
                              ? AppTheme.orange
                              : AppTheme
                                  .orange, // เปลี่ยนสีตามสถานะ หรือตามที่คุณต้องการ
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              Text(
                "Remember me",
                style: AppTheme.bodyStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withAlpha(200),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => print("Forgot password"),
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

  const LoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 300,
      child: ElevatedButton(
        onPressed: onPressed,
        style: AppTheme.primary,
        child: Text(
          "Log In",
          style: AppTheme.subheadingStyle.copyWith(color: AppTheme.cream),
        ),
      ),
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
            borderRadius: BorderRadius.circular(31), // ทำให้ปุ่มมีมุมโค้งมน
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Loading()),
            );
          },
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
