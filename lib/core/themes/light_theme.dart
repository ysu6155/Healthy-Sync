import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:pinput/pinput.dart';

ThemeData themeLight = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColor.white,
);

OutlineInputBorder borderStyle(Color color, double borderRadius) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 2.0.w),
    borderRadius: BorderRadius.circular(borderRadius ),
  );
}

final defaultPinTheme = PinTheme(
  width: 80.sp,
  height: 80.sp,
  textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
  decoration: BoxDecoration(
    border: Border.all(color: AppColor.border, width: 2.w),
    borderRadius: BorderRadius.circular(10.r),
  ),
);
