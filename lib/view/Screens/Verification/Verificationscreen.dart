import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/generated/l10n.dart';
import 'package:healthy_sync/view/Screens/Verification/Widgets/CodeVerification.dart';
import 'package:healthy_sync/view/Screens/Verification/Widgets/Timer%D9%8BWidget.dart';
import 'package:healthy_sync/view/Widgets/Button.dart';
import 'package:healthy_sync/view_model/Themes/Themedata.dart';
import 'package:healthy_sync/view_model/utils/AppAssets.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';

class VerificationScreen extends StatefulWidget {
  String Phone;

  VerificationScreen({super.key, required this.Phone});

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
          SizedBox(height: 50.sp),
          Image.asset(
            AppAssets.verification,
            height: 70.sp,
            width: 70.w,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16.sp),
          Text(
            S.of(context).verification,
            style: TextStyle(
              color: AppColor.black,
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 30.sp),
          Text(
            S.of(context).enterTheCode,
            style: TextStyle(
              color: AppColor.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.sp),
          Text.rich(
            TextSpan(
              text: S.of(context).CodeSentTo,
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
          SizedBox(height: 16.sp),
          Expanded(
            child: Container(
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
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            S.of(context).Code,
                            style: TextStyle(
                              color: AppColor.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        TimerWidget(),
                      ],
                    ),
                    SizedBox(height: 16.sp),
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
                          SizedBox(height: 30.sp),
                          Text(
                            S.of(context).codeIsRequired,
                            style: TextStyle(
                              color: AppColor.red,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    else
                      SizedBox(height: 30.sp),
                    SizedBox(height: 30.sp),
                    Button(
                      name: Text(
                        S.of(context).verify,
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
          ),
        ],
      ),
    ));
  }
}
