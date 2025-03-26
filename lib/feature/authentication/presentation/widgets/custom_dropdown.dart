import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/themes/app_color.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final String hint;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  final Color? borderColor;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.hint,

    required this.items,
    required this.onChanged,
    this.validator,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: InputBorder.none,

          focusedBorder: borderStyle(borderColor ?? AppColor.border),
          enabledBorder: borderStyle(borderColor ?? AppColor.transparent),
          errorBorder: borderStyle(AppColor.red),
          focusedErrorBorder: borderStyle(AppColor.red),
          labelStyle: textStyleBody.copyWith(
            color: AppColor.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconSize: 25.sp,
        isExpanded: true,
        value: value,
        hint: Text(
          hint,
          style: textStyle.copyWith(color: AppColor.grey, fontSize: 12.sp),
        ),
        onChanged: onChanged,
        validator: validator,
        items: items,
      ),
    );
  }
}
