import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_monday/utils/app_style.dart';
import 'package:money_monday/utils/widgets/app_style_text_field.dart';
import '../../utils/widgets/logo.dart';

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

class LoginBox extends StatelessWidget {
  TextEditingController get titleController => TextEditingController();
  const LoginBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AppWidgets.appContainer(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min, // ให้ Column มีขนาดพอดีกับเนื้อหา
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    "Log In",
                    style: AppTheme.headingStyle.copyWith(
                      color: AppTheme.orange,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ), // เพิ่มช่องว่างระหว่าง Text กับ Username
                const SizedBox(height: 5),
                const SizedBox(
                  width: 300, // กำหนดขนาด TextField (ปรับตามต้องการ)
                  child: AppStyleTextField(
                    hintText: "username / email",
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 15),
                const SizedBox(
                  width: 300, // กำหนดขนาด TextField (ปรับตามต้องการ)
                  child: AppStyleTextField(
                    hintText: "password",
                    maxLines: 1,
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 20,
                  width: 270,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Remember me",
                        style: AppTheme.bodyStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withAlpha((200).round()),
                        ),
                      ),
                      Text(
                        "Forgot pasword",
                        style: AppTheme.bodyStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withAlpha((200).round()),
                          decoration: TextDecoration.underline,
                          decorationThickness: 2.0,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: AppTheme.primary,
                    child: Text(
                      "Log In",
                      style: AppTheme.subheadingStyle.copyWith(
                        color: AppTheme.cream,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  child: Text(
                    "or",
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 45,
                  width: 300,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: BorderSide(
                        color: CupertinoColors.activeBlue,
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      "Sign in with Google",
                      style: AppTheme.subheadingStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?   ",
                        style: AppTheme.bodyStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withAlpha((200).round()),
                        ),
                      ),
                      Text(
                        "Register",
                        style: AppTheme.bodyStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.orange.withAlpha((200).round()),
                          decoration: TextDecoration.underline,
                          decorationThickness: 2.0,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationColor: AppTheme.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // คุณสามารถเพิ่ม Widget อื่น ๆ ที่ต้องการวางซ้อนทับได้ที่นี่
        ],
      ),
    );
  }
}
