import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';


class CodeVerification extends StatelessWidget {
  TextEditingController controllerCode;

   CodeVerification({super.key,required this.controllerCode });

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
          controller: controllerCode,
          decoration: InputDecoration(
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
