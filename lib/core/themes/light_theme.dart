import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:pinput/pinput.dart';

ThemeData themeLight = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColor.white,
  inputDecorationTheme:
      inputDecorationTheme(AppColor.lightGrey, AppColor.border),
);

TextStyle textButtonStyle = TextStyle(
  color: AppColor.white,
  fontSize: 20.sp,
  fontWeight: FontWeight.bold,
);

InputDecorationTheme inputDecorationTheme(Color fillColor, Color borderColor) {
  return InputDecorationTheme(
    filled: true,
    fillColor: fillColor,
    hintStyle: TextStyle(color: Colors.grey),
    border: borderStyle(borderColor),
    focusedBorder: borderStyle(borderColor),
    enabledBorder: borderStyle(borderColor),
    errorBorder: borderStyle(Colors.red),
    focusedErrorBorder: borderStyle(Colors.redAccent),
  );
}

OutlineInputBorder borderStyle(Color color) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 2.0.w),
    borderRadius: BorderRadius.circular(16.r),
  );
}

final defaultPinTheme = PinTheme(
  width: 60,
  height: 60,
  textStyle: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
  decoration: BoxDecoration(
    border: Border.all(color: AppColor.main, width: 2),
    borderRadius: BorderRadius.circular(10),
  ),
);
