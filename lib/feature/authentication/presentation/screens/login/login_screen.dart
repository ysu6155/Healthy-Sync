import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';

import 'package:healthy_sync/core/constants/enum.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/feature/authentication/presentation/widgets/form_login.dart';

class LoginScreen extends StatelessWidget {
  final UserType userType;
  const LoginScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.main,
      body: SingleChildScrollView(
        child: CustomContainer(userType: userType).paddingAll(16.sp),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final UserType userType;
  const CustomContainer({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: newMethod(userType));
  }

  Column newMethod(final UserType userType) {
    String handleUserType() {
      return userType == UserType.doctor
          ? LocaleKeys.doctor.tr()
          : LocaleKeys.patient.tr();
    }

    return Column(
      spacing: 8.sp,
      children: [
        15.H,
        Opacity(
          opacity: 0.70,
          child: Image.asset(AppAssets.logo, height: 200.h, fit: BoxFit.cover),
        ),
        Text(
          " ${LocaleKeys.loginToYourAccount.tr()} ${handleUserType()}",
          style: TextStyles.font20PinkBold,
        ),
        FormLogin(userType: userType),
      ],
    );
  }
}
