import 'package:flutter/material.dart';

sealed class AppColor {
  //static Color main = Color(0xff003445);
  static Color main = Color(0xffD8037C);
  static Color main2 = Color(0xfF7DA7ED);
  static Color secondary = Color(0xff0095C9);
  static Color backgroundColor = Color(0xffE2E2E2);
  static Color border = Color(0xff7DA7ED);

  //  static Color secondary = Color(0xffFF5BA5);
  static Color accent = Color(0xffFFA62B);
  static Color white = Color(0xffFFFFFF);
  static Color black = Color(0xff000000);
  static Color grey = Color(0xff707070);
  static Color lightGrey = Color(0xffF5F5F5);
  static Color darkGrey = Color(0xffA9A9A9);
  static Color red = Color(0xffFF0000);
  static Color accentRed = Color(0xffFF5A5F);
  static Color amber = Color(0xffFFC107);
  static Color green = Color(0xff4CAF50);
  static Color white60 = Color(0x99FFFFFF);
  static LinearGradient primaryGradient = LinearGradient(
    colors: [AppColor.main, AppColor.secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF4A00E0), Color(0xFFD9047D), Color(0xFFFF5BA5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient primaryGradientLight = LinearGradient(
    colors: [AppColor.black, AppColor.white], // الألوان هنا
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  );
  static Color greenShade100 = Color(0xffC8E6C9);
  static Color redShade200 = Color(0xffFFCDD2);
  static Color orangeShade200 = Color(0xffFFE0B2);
  static Color greenShade800 = Color(0xff2E7D32);
  static Color orange = Color(0xffFF9800);
  static Color blue = Color(0xff2196F3);
  static Color yellow = Color(0xffFFEB3B);
  static Color transparent = Colors.transparent;
  static Color purple = Color(0xff9C27B0);
  static Color brown = Color(0xff795548);
  static Color teal = Color(0xff009688);
  static Color pink = Color(0xffE91E63);
}
