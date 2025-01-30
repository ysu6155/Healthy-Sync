
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';

Widget buildPage(
    {required String image,
      required String title,
      required String description}) {
  return Column(
    children: [
      Image.asset(
        image,
         height: 350.h,
         width: double.infinity.w,
         fit: BoxFit.cover,
      ),
      SizedBox(height: 30.sp),
      Text(
        title,
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: AppColor.black,
        ),
      ),
      SizedBox(height: 15.sp),
      Text(
        description,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColor.black,
        ),
      ),
    ],
  );
}