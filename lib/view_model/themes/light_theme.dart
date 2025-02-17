import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/view_model/utils/app_color.dart';

ThemeData themeLight = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColor.white,
  inputDecorationTheme:
      inputDecorationTheme(AppColor.lightGrey, AppColor.border),
);

TextStyle textButtonStyle = TextStyle(
  color: AppColor.white,
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
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
