import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/enum/enum.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/feature/authentication/presentation/widgets/form_signup.dart';

class SignUpScreen extends StatelessWidget {
  final UserType userType;
  const SignUpScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.createAccount.tr(), style: textStyleTitle),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColor.white, size: 24.sp),
        backgroundColor: AppColor.main,
      ),
      body: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(color: AppColor.main),
          child: SingleChildScrollView(
            child: Column(
              children: [
                30.H,
                Text(LocaleKeys.joinNow.tr(), style: textStyleBody),
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
                  child: FormSignUp(userType: userType),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
