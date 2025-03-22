import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/Themes/light_theme.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/widgets/responsive_helper.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword && !isPasswordVisible,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      decoration: InputDecoration(
        
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
        hintStyle: textStyle.copyWith(fontSize: 16.sp, color: AppColor.grey),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    !isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    size: 20.sp,
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
    );
  }
}
