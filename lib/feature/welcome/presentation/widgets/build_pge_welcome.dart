import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';

Widget buildPage({
  required String image,
  required String title,
  required String description,
}) {
  return Column(
    children: [
      SvgPicture.asset(
        image,
        height: 350.sp,
        width: double.infinity.w,
        fit: BoxFit.cover,
      ),
      15.H,
      Text(title, style: textStyleTitle.copyWith(color: AppColor.main)),
      12.H,
      Text(
        description,
        textAlign: TextAlign.center,
        style: textStyleBody.copyWith(color: AppColor.main),
      ),
    ],
  );
}
