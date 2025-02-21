import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
class CustomButton extends StatelessWidget {
 final Widget name;
 final Gradient? backgroundColor;
 final Color? textColor;
  final void Function() onTap;
  const CustomButton ({super.key,required this.name, this.backgroundColor, this.textColor,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Ink(
      height: 48.sp,
      decoration: BoxDecoration(
       gradient:backgroundColor??AppColor.primaryGradient,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Center(
          child: name
      ),
    ).withTapEffect( onTap: onTap);
  }
}
