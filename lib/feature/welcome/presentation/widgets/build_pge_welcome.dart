
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/themes/app_color.dart';

Widget buildPage({
  required String image,
  required String title,
  required String description,
  required BuildContext context,
}) {
  return Column(
    children: [
      SvgPicture.asset(
        image,
        height: 350.h,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          children: [
            Text(
              title,
              style: textStyleTitle.copyWith(color: AppColor.mainPink),
            ),
            SizedBox(height: 10.h),
            Text(
              description,
              style: textStyleBody.copyWith(color: AppColor.black),
            ),
            SizedBox(height: 20.h),
            
          ],
        ),
      ),
    ],
  );
}
