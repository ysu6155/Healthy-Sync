import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';

Widget buildDot({required int index, required currentPage}) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    margin: EdgeInsets.only(right: 8.sp),
    height: 10.sp,
    width: 10.w,
    decoration: BoxDecoration(
      color: currentPage == index ? AppColor.mainBlue : AppColor.darkGrey,
      borderRadius: BorderRadius.circular(5.r),
    ),
  );
}
