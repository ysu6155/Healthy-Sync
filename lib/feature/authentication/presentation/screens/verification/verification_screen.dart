import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/verification_cubit/cubit/verification_cubit.dart';
import 'package:healthy_sync/feature/authentication/presentation/widgets/timer_widget.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_assets.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatefulWidget {
  final String phone;

  const VerificationScreen({super.key, required this.phone});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    var cubitOTB = context.read<VerificationCubit>();
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        color: AppColor.main,
      ),
      child: Column(
        children: [
          50.H,
          Image.asset(
            AppAssets.verification,
            height: 70.sp,
            width: 70.w,
            fit: BoxFit.cover,
          ),
          16.H,
          Text(
            LocaleKeys.verification.tr(),
            style: TextStyle(
              color: AppColor.white,
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          30.H,
          Text(
            LocaleKeys.enterTheCode.tr(),
            style: TextStyle(
              color: AppColor.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          16.H,
          Text.rich(
            TextSpan(
              text: LocaleKeys.CodeSentTo.tr(),
              style: TextStyle(
                color: AppColor.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: widget.phone,
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          16.H,
          Container(
            height: 300.sp,
            width: double.infinity.w,
            padding: EdgeInsets.all(24.sp),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        LocaleKeys.Code.tr(),
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    8.W,
                    TimerWidget(),
                  ],
                ),
                16.H,
                Pinput(
                  controller: cubitOTB.pinController,
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme,
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: BoxDecoration(
                      color: AppColor.secondary,
                      border: Border.all(color: AppColor.secondary, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onCompleted: (pin) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Entered PIN: $pin")),
                    );
                    cubitOTB.isCodeEmptyShown = false;
                  },
                ),
                if (cubitOTB.isCodeEmptyShown)
                  Column(
                    children: [
                      30.H,
                      Text(
                        cubitOTB.text ?? LocaleKeys.codeIsRequired.tr(),
                        style: TextStyle(
                          color: AppColor.red,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                else
                  30.H,
                30.H,
                CustomButton(
                  name: Text(
                    LocaleKeys.verify.tr(),
                    style: textButtonStyle,
                  ),
                  onTap: () {
                    setState(() {
                      if (cubitOTB.pinController.text.length < 4) {
                        cubitOTB.text = "❌ لازم تدخل 4 أرقام!";
                        log("❌ لازم تدخل 4 أرقام!");
                        cubitOTB.isCodeEmptyShown = true;
                      } else {
                        log("✅ الكود صحيح: ${cubitOTB.pinController.text}");
                        cubitOTB.isCodeEmptyShown = false;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ).scrollable(),
    ));
  }
}
