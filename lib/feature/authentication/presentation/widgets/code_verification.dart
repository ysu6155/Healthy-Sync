import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/utils/app_color.dart';


class CodeVerification extends StatelessWidget {
 final TextEditingController controllerCode;

   const CodeVerification({super.key,required this.controllerCode });

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 50.w,
      height: 50.sp,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: TextFormField(
          maxLength: 1,
          textAlign: TextAlign.center,
          controller: controllerCode,
          decoration: InputDecoration(
            errorMaxLines: 1,
            border: InputBorder.none,
          ),

          validator: (value) {
            if (value!.isEmpty) {
              return "";
            }
          },
        ),
      ),
    );
  }
}
