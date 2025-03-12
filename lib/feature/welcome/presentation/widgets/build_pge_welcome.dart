import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';

Widget buildPage({
  required String image,
  required String title,
  required String description,
}) {
  return Column(
    children: [
      Image.asset(
        image,
        height: 400.sp,
        width: double.infinity.w,
        fit: BoxFit.cover,
      ),
      20.H,
      Text(
        title,
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: AppColor.black,
        ),
      ),
      12.H,
      Text(
        description,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16.sp, color: AppColor.black),
      ),
    ],
  );
}
