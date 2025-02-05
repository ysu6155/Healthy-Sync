import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/view_model/Themes/Themedata.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';



class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? togglePasswordVisibility;
  final String? Function(String?)? validator;
  FloatingLabelBehavior? floatingLabelBehavior;
  String? labelText;
  TextStyle? labelStyle;

  CustomTextField(
      {Key? key,
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
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword && !isPasswordVisible,
      decoration: InputDecoration(
        floatingLabelBehavior: floatingLabelBehavior,
        labelText: labelText,
        labelStyle: labelStyle,
        hintText: hintText,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,size: 20.sp,
                ),
                onPressed: togglePasswordVisibility,
              )
            : null,
      ),
      style: textButtonStyle.copyWith(
        color: AppColor.black,
      ),
      validator: validator,
    );
  }
}
