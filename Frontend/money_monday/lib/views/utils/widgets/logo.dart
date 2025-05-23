import 'package:flutter/material.dart';

class LogoAndLableImageCream extends StatelessWidget {
  final double width;
  final double height;

  const LogoAndLableImageCream({
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

class LogoAndLableImageOrange extends StatelessWidget {
  final double width;
  final double height;

  const LogoAndLableImageOrange({
    super.key,
    this.width = 250, // default value ถ้าไม่ส่งมาก็ใช้ค่านี้
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset('assets/images/Logo&text.png', fit: BoxFit.contain),
    );
  }
}

class LogoImageCream extends StatelessWidget {
  final double width;
  final double height;

  const LogoImageCream({
    super.key,
    this.width = 250, // default value ถ้าไม่ส่งมาก็ใช้ค่านี้
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset('assets/images/Logo(cream).png', fit: BoxFit.contain),
    );
  }
}

class LogoImageOrange extends StatelessWidget {
  final double width;
  final double height;

  const LogoImageOrange({
    super.key,
    this.width = 250, // default value ถ้าไม่ส่งมาก็ใช้ค่านี้
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset('assets/images/Logo(orange).png', fit: BoxFit.contain),
    );
  }
}

class SuccessImage extends StatelessWidget {
  final double width;
  final double height;

  const SuccessImage({
    super.key,
    this.width = 250, // default value ถ้าไม่ส่งมาก็ใช้ค่านี้
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset('assets/images/Success.png', fit: BoxFit.contain),
    );
  }
}

class FailImage extends StatelessWidget {
  final double width;
  final double height;

  const FailImage({
    super.key,
    this.width = 250, // default value ถ้าไม่ส่งมาก็ใช้ค่านี้
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset('assets/images/Fail.png', fit: BoxFit.contain),
    );
  }
}
