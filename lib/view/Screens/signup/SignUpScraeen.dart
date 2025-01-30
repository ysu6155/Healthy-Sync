import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/generated/l10n.dart';
import 'package:healthy_sync/view/Screens/signup/Widgets/FormSiginUp.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            gradient: AppColor.primaryGradient,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                 SizedBox(height: 90.sp),
                 Text(
                   S.of(context).createAccount,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                 Text(
                   S.of(context).joinNow,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                 SizedBox(height: 30.sp),
                Container(
                  padding:  EdgeInsets.all(24.sp),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius:  BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                  child: FormSiginUp(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}