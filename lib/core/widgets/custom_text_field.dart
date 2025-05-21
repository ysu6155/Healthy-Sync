import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/Themes/light_theme.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
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
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final OutlineInputBorder? border;
  final Color? iconColor;
  final Color? borderColor;
  final Color? fillColor;
  final TextStyle? hintTextStyle;
  final bool isEnabled;
  final double? borderRadius;
  final IconData? suffixIcon;
  const CustomTextField({
    super.key,
    this.hintTextStyle,
    this.borderRadius,
    this.controller,
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
    this.onChanged,
    this.focusNode,
    this.border,
    this.borderColor,
    this.fillColor,
    this.contentPadding,
    this.isEnabled = true,
    this.iconColor,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey.withValues(alpha: 0.3),
            // شادو خفيف جدًا
            spreadRadius: 0.4, // نشر بسيط
            blurRadius: 4.4, // ضبابية خفيفة
            offset: Offset(0, 0.4), // ارتفاع بسيط للشادو
          ),
        ],
      ),
      child: TextFormField(
        enabled: isEnabled,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword && !isPasswordVisible,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        focusNode: focusNode,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(horizontal: 20.sp, vertical: 18.h),
          filled: true,
          fillColor: fillColor ?? AppColor.white,
          hintStyle: hintTextStyle ?? TextStyles.font12GreyW400,
          border: border ??
              borderStyle(borderColor ?? AppColor.border, borderRadius ?? 16.r),
          focusedBorder: borderStyle(
            borderColor ?? AppColor.border,
            borderRadius ?? 16.r,
          ),
          enabledBorder: borderStyle(
            borderColor ?? AppColor.transparent,
            borderRadius ?? 16.r,
          ),
          errorBorder: borderStyle(AppColor.red, borderRadius ?? 16.r),
          focusedErrorBorder: borderStyle(AppColor.red, borderRadius ?? 16.r),
          floatingLabelBehavior: floatingLabelBehavior,
          labelText: labelText,
          labelStyle: labelStyle ??
              TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
          hintText: hintText,
          prefixIcon: icon != null
              ? Icon(icon, size: 25.sp, color: iconColor ?? AppColor.black)
              : null,
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: togglePasswordVisibility,
                  child: Icon(
                    !isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 20.sp,
                    color: AppColor.grey,
                  ),
                )
              : null,
          errorStyle: TextStyles.font12BlueW400.copyWith(color: AppColor.red),
        ),
        style: TextStyles.font12BlueW400.copyWith(
          fontSize: ResponsiveHelper.isMobile(context) ? 16.sp : 24.sp,
          color: AppColor.black,
        ),
        validator: validator,
      ),
    );
  }
}
