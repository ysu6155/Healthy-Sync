// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:healthy_sync/core/utils/app_color.dart';

// ignore: must_be_immutable
class CustomForm1 extends StatelessWidget {
  Widget widget1;
  Widget widget2;
  CustomForm1({
    super.key,
    required this.widget1,
    required this.widget2,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(color: AppColor.main,),
        child: SingleChildScrollView(
          child: Column(
            spacing: 8.sp,
            children: [
              widget1,
              Container(
                padding: EdgeInsets.all(24.r),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                ),
                child: widget2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
