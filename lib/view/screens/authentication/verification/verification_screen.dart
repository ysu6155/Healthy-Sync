import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/view/Screens/authentication/verification/widgets/code_verification.dart';
import 'package:healthy_sync/view/Screens/authentication/verification/widgets/timer_widget.dart';
import 'package:healthy_sync/view/widgets/custom_button.dart';
import 'package:healthy_sync/view_model/themes/light_theme.dart';
import 'package:healthy_sync/view_model/translations/locale_keys.g.dart';
import 'package:healthy_sync/view_model/utils/app_assets.dart';
import 'package:healthy_sync/view_model/utils/app_color.dart';
import 'package:healthy_sync/view_model/utils/extensions.dart';

class VerificationScreen extends StatefulWidget {
 final String Phone;

  const VerificationScreen({super.key, required this.Phone});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController code1 = TextEditingController();
  TextEditingController code2 = TextEditingController();
  TextEditingController code3 = TextEditingController();
  TextEditingController code4 = TextEditingController();

  bool isCodeEmptyShown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: AppColor.primaryGradientLight,
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
              color: AppColor.black,
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
         30.H,
          Text(
            LocaleKeys.enterTheCode.tr(),
            style: TextStyle(
              color: AppColor.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
         16.H,
          Text.rich(
            TextSpan(
              text: LocaleKeys.CodeSentTo.tr(),
              style: TextStyle(
                color: AppColor.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: widget.Phone,
                  style: TextStyle(
                    color: AppColor.black,
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
            child: Form(
              key: formKey,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CodeVerification(
                        controllerCode: code1,
                      ),
                      CodeVerification(
                        controllerCode: code2,
                      ),
                      CodeVerification(controllerCode: code3),
                      CodeVerification(
                        controllerCode: code4,
                      )
                    ],
                  ),
                  if (isCodeEmptyShown)
                    Column(
                      children: [
                       30.H,
                        Text(
                          LocaleKeys.codeIsRequired.tr(),
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
                      if (formKey.currentState!.validate()) {
                        print("Verify");
                      } else {
                        setState(() {
                          isCodeEmptyShown =
                              true; // قم بتحديث الحالة لعرض النص بعد الضغط
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ).scrollable(),
    ));
  }
}
