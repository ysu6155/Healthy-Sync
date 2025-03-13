import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/feature/authentication/presentation/widgets/form_signup.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.createAccount.tr(),
          style: TextStyle(
            color: AppColor.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColor.white),
        backgroundColor: AppColor.main,
      ),
      body: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.main,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                30.H,
                Text(
                  LocaleKeys.joinNow.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 24.sp,
                  ),
                ),
                30.H,
                Container(
                  padding: EdgeInsets.all(24.sp),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                  child: FormSignUp(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
