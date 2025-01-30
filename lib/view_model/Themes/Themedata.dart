import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';


ThemeData themeLight = ThemeData(
  scaffoldBackgroundColor: AppColor.white,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColor.lightGrey,
    hintStyle: TextStyle(color: Colors.grey),
    border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.border, width: 2.0.w),
        borderRadius: BorderRadius.circular(20)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.border, width: 2.0.w),
        borderRadius: BorderRadius.circular(16)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.border, width: 2.0.w),
      borderRadius: BorderRadius.circular(16),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.red, width: 2.0.w),
      borderRadius: BorderRadius.circular(16),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.accentRed, width: 2.0.w),
      borderRadius: BorderRadius.circular(16),
    ),
  ),
);
TextStyle textButtonStyle = TextStyle(
  color: AppColor.white,
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
);
