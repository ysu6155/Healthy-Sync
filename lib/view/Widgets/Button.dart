import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';
class Button extends StatelessWidget {
  Widget name;
  Gradient? backgroundColor;
  Color? textColor;
  void Function() onTap;
   Button ({super.key,required this.name, this.backgroundColor, this.textColor,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        height: 48.sp,
        decoration: BoxDecoration(
         gradient:backgroundColor??AppColor.primaryGradient,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Center(
            child: name
        ),
      ),
    );
  }
}
