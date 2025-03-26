import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/constants/enum.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/feature/authentication/presentation/widgets/form_signup.dart';

class SignUpScreen extends StatelessWidget {
  final UserType userType;
  const SignUpScreen({super.key, required this.userType});
  String handleUserType() {
    return userType == UserType.doctor ? 'دكتور' : 'مريض';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              15.H,
              Image.asset(AppAssets.logo, height: 200.h, fit: BoxFit.cover),
              15.H,
              Text(
                " ${LocaleKeys.signUp.tr()} ${handleUserType()}",
                style: textStyleTitle.copyWith(color: AppColor.mainPink),
              ),
              30.H,
              FormSignUp(userType: userType),
            ],
          ).paddingAll(16.sp),
        ),
      ),
    );
  }
}
