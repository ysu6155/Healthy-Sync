import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/Themes/light_theme.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/core/themes/app_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? togglePasswordVisibility;
  final String? Function(String?)? validator;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final OutlineInputBorder? border;

  final Color? borderColor;
  final Color? fillColor;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.togglePasswordVisibility,
    this.validator,
    this.floatingLabelBehavior,
    this.labelText,
    this.labelStyle,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
    this.focusNode,
    this.border,
    this.borderColor,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.white,
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
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword && !isPasswordVisible,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        focusNode: focusNode,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.white,
          hintStyle: textStyle.copyWith(color: AppColor.grey, fontSize: 12.sp),
          border: borderStyle(borderColor ?? AppColor.border),
          focusedBorder: borderStyle(borderColor ?? AppColor.border),
          enabledBorder: borderStyle(borderColor ?? AppColor.transparent),
          errorBorder: borderStyle(AppColor.red),
          focusedErrorBorder: borderStyle(AppColor.red),
          floatingLabelBehavior: floatingLabelBehavior,
          labelText: labelText,
          labelStyle:
              labelStyle ??
              TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
          hintText: hintText,

          suffixIcon:
              isPassword
                  ? IconButton(
                    icon: Icon(
                      !isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 20.sp,
                      color: AppColor.grey,
                    ),
                    onPressed: togglePasswordVisibility,
                  )
                  : null,
          errorStyle: textStyle.copyWith(color: AppColor.red),
        ),
        style: textStyle.copyWith(
          fontSize: ResponsiveHelper.isMobile(context) ? 16.sp : 24.sp,
          color: AppColor.black,
        ),

        validator: validator,
      ),
    );
  }
}
