import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:pinput/pinput.dart';

ThemeData themeLight = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColor.white,
);

TextStyle textStyleTitle = TextStyle(
  color: AppColor.white,
  fontSize: 20.sp,
  fontWeight: FontWeight.bold,
);
TextStyle textStyleBody = TextStyle(
  color: AppColor.mainBlue,
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
);

TextStyle textStyle = TextStyle(
  color: AppColor.white,
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
);

OutlineInputBorder borderStyle(Color color) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 2.0.w),
    borderRadius: BorderRadius.circular(16.r),
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
