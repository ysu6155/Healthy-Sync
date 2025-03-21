import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:healthy_sync/core/enum/enum.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/feature/authentication/presentation/widgets/form_login.dart';

class LoginScreen extends StatelessWidget {
  final UserType userType;
  const LoginScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.login.tr(), style: textStyleTitle),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColor.white, size: 24.sp),
        backgroundColor: AppColor.main,
      ),
      // backgroundColor: AppColor.main,
      body: CustomContainer(userType: userType),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final UserType userType;
  const CustomContainer({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(color: AppColor.main),
        child: SingleChildScrollView(child: newMethod(userType)),
      ),
    );
  }

  Column newMethod(final UserType userType) {
    String handleUserType() {
      return userType == UserType.doctor ? 'دكتور' : 'مريض';
    }

    return Column(
      spacing: 8.sp,
      children: [
        50.H,
        Text(LocaleKeys.welcomeToHealthySync.tr(), style: textStyleTitle),
        Text(
          " ${LocaleKeys.loginToYourAccount.tr()} ${handleUserType()}",
          style: textStyleBody,
        ),
        30.H,
        Container(
          padding: EdgeInsets.all(24.r),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: FormLogin(userType: userType),
        ),
      ],
    );
  }
}
