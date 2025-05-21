import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_monday/models/user_model.dart';
import 'package:money_monday/viewmodels/register_view_model.dart';
import 'package:money_monday/views/auth/login_page.dart';
import 'package:money_monday/views/utils/app_style.dart';
import 'package:money_monday/views/utils/widgets/app_style_container.dart';
import 'package:money_monday/views/utils/widgets/app_style_text_field.dart';
import 'package:money_monday/views/utils/widgets/logo.dart';
import 'package:provider/provider.dart';

/// Main Register Page
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.orange,
      body: Row(
        children: const [
          Expanded(flex: 2, child: LeftSide()),
          Expanded(child: RightSide()),
        ],
      ),
    );
  }
}

/// Right Side of the Register Page
class RightSide extends StatelessWidget {
  const RightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: -150, // Shift left to create a curve that overflows
          top: 0,
          right: 0,
          bottom: 0,
          child: ClipPath(
            clipper: _RightSideCurve(),
            child: Container(
              color: AppTheme.cream,
              width: double.infinity,
              height: double.infinity,
              child: _RightInside(),
            ),
          ),
        ),
      ],
    );
  }
}

class _RightSideCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final x = size.width;
    final y = size.height;
    Path path = Path();
    path.moveTo(x, 0); // 1
    path.lineTo(x * 0.35, 0); // 2
    path.quadraticBezierTo(0, y * 0.5, x * 0.16, y);
    path.lineTo(x, y); // 4
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _RightInside extends StatefulWidget {
  const _RightInside();

  @override
  State<_RightInside> createState() => _RightInsideState();
}

class _RightInsideState extends State<_RightInside> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final rightPadding = screenWidth * 0.02;

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: rightPadding),
        child: SizedBox(
          width: 370,
          child: Stack(
            children: [
              const Positioned(
                top: -40,
                left: 0,
                right: 0,
                child: LogoAndLableImageOrange(height: 250, width: 250),
              ),
              const Positioned(
                top: 190,
                child: Text(
                  "Alread have an \naccount?",
                  style: AppTheme.headingStyle,
                ),
              ),
              Positioned(
                top: 280,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 120,
                      child: LoginButton(onPressed: () => context.pop()),
                    ),
                    Text("  or", style: AppTheme.subheadingStyle),
                  ],
                ),
              ),
              Positioned(top: 340, child: GoogleSignInButton()),
              Positioned(
                top: 390,
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.asset("assets/images/Graph.png"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return RegisterBox();
  }
}

class RegisterBox extends StatefulWidget {
  const RegisterBox({super.key});

  @override
  State<RegisterBox> createState() => _RegisterBoxState();
}

class _RegisterBoxState extends State<RegisterBox> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _usernameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  final _signUpFocus = FocusNode();

  bool hidePassword = true;
  bool hideConfirmPasword = true;

  void _signup() async {
    final User user = User(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (_formKey.currentState!.validate()) {
      if (!(_passwordController.text == _confirmPasswordController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("password not matching!"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      final registerVM = context.read<RegisterViewModel>();

      await registerVM.register(user);

      if (!mounted) return;

      if (registerVM.userResponse != null) {
        registeredDialog();
      } else if (registerVM.errorMessage != null) {
        registerFailDialog(registerVM.errorMessage);
      }
    }
  }

  void registeredDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.cream,
          title: AppWidgets.appContainer(
            width: 680 * 0.7,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SuccessImage(width: 100, height: 130),
                  Text(
                    "Registration Successful!",
                    style: AppTheme.headingStyle.copyWith(
                      fontSize: 32,
                      color: AppTheme.orange,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Thank you for joining us",
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "You can now log in to start using your account.",
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  LoginButton(
                    onPressed: () {
                      context.go("/");
                    },
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void registerFailDialog(final String? errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.cream,
          title: AppWidgets.appContainer(
            width: 680 * 0.7,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const FailImage(width: 100, height: 130),
                  Text(
                    "Registration Fail!",
                    style: AppTheme.headingStyle.copyWith(
                      fontSize: 32,
                      color: AppTheme.orange,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "please try again",
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "$errorMessage",
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 45,
                    width: 350,
                    child: ElevatedButton(
                      style: AppTheme.primaryButton,
                      onPressed: () => context.pop(),
                      child: Text(
                        "Back",
                        style: AppTheme.subheadingStyle.copyWith(
                          color: AppTheme.cream,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Align(
        alignment: const Alignment(
          -0.2,
          0,
        ), // ค่าระหว่าง -1 (ซ้ายสุด) ถึง 1 (ขวาสุด)
        child: SingleChildScrollView(
          child: AppStyleContainer(
            height: 600,
            width: 450,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Sign up",
                  style: AppTheme.headingStyle.copyWith(color: AppTheme.orange),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 350,
                  child: Text(
                    "    Username",
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                UsernameTextField(
                  controller: _usernameController,
                  focusNode: _usernameFocus,
                  nextFocusNode: _emailFocus,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 350,
                  child: Text(
                    "    Email",
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                EmailTextField(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  nextFocusNode: _passwordFocus,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 350,
                  child: Text(
                    "    Password",
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                PasswordTextField(
                  onChanged: (hide) => setState(() => hidePassword = hide),
                  hide: hidePassword,
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  nextFocusNode: _confirmPasswordFocus,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 350,
                  child: Text(
                    "    Confirm password",
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ConfirmPasswordTextField(
                  onChanged:
                      (hide) => setState(() => hideConfirmPasword = hide),
                  hide: hideConfirmPasword,
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocus,
                  nextFocusNode: _signUpFocus,
                ),
                const SizedBox(height: 20),
                Consumer<RegisterViewModel>(
                  builder: (context, registerVM, child) {
                    return registerVM.isLoading
                        ? const CircularProgressIndicator()
                        : SignupButton(
                          onPressed: _signup,
                          focusNode: _signUpFocus,
                        );
                  },
                ),
              ],
            ),
          ),
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
      width: 350,
      child: AppStyleTextFormField(
        hintText: "username",
        maxLines: 1,
        validatorText: "Enter username",
        controller: controller,
        focusNode: focusNode,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  const EmailTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: AppStyleTextFormField(
        hintText: "email",
        maxLines: 1,
        validatorText: "Enter email",
        controller: controller,
        focusNode: focusNode,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
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
      width: 350,
      child: AppStyleTextFormField(
        hintText: "password",
        maxLines: 1,
        obscureText: hide,
        controller: controller,
        validatorText: "Enter password",
        focusNode: focusNode,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
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

class ConfirmPasswordTextField extends StatelessWidget {
  final bool hide;
  final ValueChanged<bool> onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  const ConfirmPasswordTextField({
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
      width: 350,
      child: AppStyleTextFormField(
        hintText: "confirm password",
        maxLines: 1,
        obscureText: hide,
        controller: controller,
        validatorText: "Enter confirm password",
        focusNode: focusNode,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
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

class SignupButton extends StatelessWidget {
  final FocusNode? focusNode;
  final VoidCallback onPressed;

  const SignupButton({super.key, required this.onPressed, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 350,
      child: ElevatedButton(
        focusNode: focusNode,
        onPressed: onPressed,
        style: AppTheme.primaryButton,
        child: Text(
          "Sign up",
          style: AppTheme.subheadingStyle.copyWith(color: AppTheme.cream),
        ),
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
      width: 350,
      child: ElevatedButton(
        style: AppTheme.primaryButton,
        onPressed: onPressed,
        child: Text(
          "Log in",
          style: AppTheme.subheadingStyle.copyWith(color: AppTheme.cream),
        ),
      ),
    );
  }
}
