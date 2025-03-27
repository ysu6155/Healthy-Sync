import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final VoidCallback onTap;
  final Border? border;
  final double? height;
  final double? width;
  final double? borderRadius;

  const CustomButton({
    super.key,
    required this.name,
    this.backgroundColor,
    this.textStyle,
    required this.onTap,
    this.border,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: width?.w ?? 1.sw,
      height: height?.sp ?? 48.sp,
      decoration: BoxDecoration(
        border: border ?? Border.all(color: AppColor.transparent, width: 2.sp),
        // gradient: backgroundColor ?? AppColor.primaryGradient,
        color: backgroundColor ?? AppColor.mainPink,
        borderRadius: BorderRadius.circular(borderRadius?.r ?? 16.r),
      ),
      child: Center(
        child: Text(name, style: textStyle ?? TextStyles.font20WhiteBold),
      ),
    ).withTapEffect(onTap: onTap);
  }
}
