import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/verification_cubit/cubit/verification_cubit.dart';
import 'package:healthy_sync/feature/authentication/presentation/widgets/timer_widget.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
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
      appBar: AppBar(
        backgroundColor: AppColor.white,
        iconTheme: IconThemeData(color: AppColor.black, size: 24.sp),
        centerTitle: true,
        title: Text(
          LocaleKeys.verification.tr(),
          style: TextStyles.font12DarkBlueW400
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.sp),
        child:
            Column(
              children: [
                Image.asset(
                  AppAssets.verification,
                  height: 70.sp,
                  width: 70.w,
                  fit: BoxFit.cover,
                ),

                30.H,
                Text(
                  LocaleKeys.enterTheCode.tr(),
                  style: TextStyles.font12DarkBlueW400
                ),
                16.H,
                Text.rich(
                  TextSpan(
                    text: LocaleKeys.CodeSentTo.tr(),
                    style: TextStyles.font12DarkBlueW400,
                    children: [
                      TextSpan(
                        text: widget.phone,
                        style: TextStyles.font12DarkBlueW400
                      ),
                    ],
                  ),
                ),
                16.H,
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            LocaleKeys.Code.tr(),
                            style:TextStyles.font12DarkBlueW400
                          ),
                        ),
                        8.W,
                        TimerWidget(),
                      ],
                    ),
                    16.H,
                    Pinput(
                      showCursor: false,
                      controller: cubitOTB.pinController,
                      length: 4,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: defaultPinTheme,
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: BoxDecoration(
                          color: AppColor.secondary,
                          border: Border.all(
                            color: AppColor.secondary,
                            width: 2,
                          ),
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
                            style: TextStyles.font12DarkBlueW400
                          ),
                        ],
                      )
                    else
                      30.H,
                    30.H,
                    CustomButton(
                      name:LocaleKeys.verify.tr(),
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
              ],
            ).scrollable(),
      ),
    );
  }
}
