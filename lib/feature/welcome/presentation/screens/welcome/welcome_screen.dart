import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/constants/enum.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/feature/authentication/presentation/screens/login/login_screen.dart';

import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Image.asset(
              AppAssets.welcome,
              fit: BoxFit.cover,
              width: 1.sw,
              height: 1.sh,
            ),

            PositionedDirectional(
              start: 16.sp,
              end: 16.sp,
              top: 100.sp,

              child: Column(
                children: [
                  50.H,
                  Text(
                    LocaleKeys.welcomeToHealthySync.tr(),
                    style: textStyleTitle.copyWith(
                      color: AppColor.mainPink,
                      fontSize: 26.sp,
                    ),
                  ),
                  30.H,
                  Text(
                    LocaleKeys.joinNow.tr(),
                    style: textStyleTitle.copyWith(color: AppColor.mainPink),
                  ),
                  30.H,
                ],
              ),
            ),

            15.H,
            PositionedDirectional(
              bottom: 40.sp,
              start: 16.sp,
              end: 16.sp,
              top: ResponsiveHelper.isMobile(context) ? 500.sp : 330.sp,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                width: 1.sw,
                height: 200.sp,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.secondary.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(16.sp),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(LocaleKeys.LoginBy.tr(), style: textStyleTitle),
                    16.H,
                    CustomButton(
                      name: Text(LocaleKeys.doctor.tr(), style: textStyleTitle),
                      backgroundColor: AppColor.mainPink,
                      onTap: () {
                        context.push(LoginScreen(userType: UserType.doctor));
                      },
                    ),
                    16.H,
                    CustomButton(
                      // border: Border.all(color: AppColor.black, width: 3.sp),
                      name: Text(
                        LocaleKeys.patient.tr(),
                        style: textStyleTitle,
                      ),
                      backgroundColor: AppColor.mainPink,
                      textColor: AppColor.black,
                      onTap: () {
                        context.push(LoginScreen(userType: UserType.patient));
                      },
                    ),
                    8.H,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
