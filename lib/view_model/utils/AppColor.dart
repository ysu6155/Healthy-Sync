import 'package:flutter/material.dart';

class AppColor {
  static Color main = Color(0xff003445);
  static Color secondary = Color(0xff0180AB);
  static Color accent = Color(0xffFFA62B);
  static Color white = Color(0xffFFFFFF);
  static Color black = Color(0xff000000);
  static Color grey = Color(0xff707070);
  static Color lightGrey = Color(0xffF5F5F5);
  static Color darkGrey = Color(0xffA9A9A9);
  static Color red = Color(0xffFF0000);
  static Color accentRed = Color(0xffFF5A5F);
  static Color backgroundColor = Color(0xffE2E2E2);
  static Color border = Color(0xff0095C9);
  static Color amber = Colors.amber;
  static Color green = Colors.green;
  static LinearGradient primaryGradient = LinearGradient(
    colors: [AppColor.main, AppColor.secondary], // الألوان هنا
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient primaryGradientLight = LinearGradient(
    colors: [AppColor.black, AppColor.white], // الألوان هنا
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,

  );

}

