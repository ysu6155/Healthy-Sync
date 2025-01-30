import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_sync/generated/l10n.dart';
import 'package:healthy_sync/view/Widgets/Button.dart';
import 'package:healthy_sync/view/Widgets/CustomTextField.dart';
import 'package:healthy_sync/view_model/Themes/Themedata.dart';
import 'package:healthy_sync/view_model/utils/AppAssets.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';

import '../Verification/Verificationscreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final email = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          padding:  EdgeInsets.only(top: 40.sp),
          decoration: BoxDecoration(
            gradient: AppColor.primaryGradient,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  AppAssets.forgotPassword,
                  width: 130.w,
                  height: 130.sp,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 50),
                Text(
                  S.of(context).forgotPassword,
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                 SizedBox(height: 30.sp),
                Container(
                    width: double.infinity.w,
                    padding:  EdgeInsets.all(24.sp),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius:  BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 16.sp,
                          ),
                          CustomTextField(
                              controller: email,
                              labelText: S.of(context).emailPhone,
                              labelStyle: TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: S.of(context).enterYourEmailOrPhone,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return S.of(context).emailIsRequired;
                                }
                                return null;
                              }),
                           SizedBox(height: 32.sp),
                          Button(
                            name: Text(S.of(context).sendCode,style: textButtonStyle,),
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VerificationScreen(Phone: email.text,)));
                              }
                            },
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
