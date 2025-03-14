import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';
import 'package:healthy_sync/feature/authentication/presentation/screens/Verification/verification_screen.dart';
import 'package:healthy_sync/core/Themes/light_theme.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_assets.dart';
import 'package:healthy_sync/core/utils/app_color.dart';

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
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColor.white),
        backgroundColor: AppColor.main,
        title: Text(LocaleKeys.forgotPassword.tr(), style: textStyle),
      ),
      body: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.only(top: 40.sp),
          decoration: BoxDecoration(color: AppColor.main),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  AppAssets.forgotPassword,
                  width: 130.w,
                  height: 130.sp,
                  fit: BoxFit.cover,
                ),
                32.H,
                Container(
                  width: 1.sw,
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
                        16.H,
                        CustomTextField(
                          controller: email,
                          labelText: LocaleKeys.emailPhone.tr(),
                          labelStyle: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: LocaleKeys.enterYourEmailOrPhone.tr(),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.emailIsRequired.tr();
                            }
                            return null;
                          },
                        ),
                        32.H,
                        CustomButton(
                          name: Text(
                            LocaleKeys.sendCode.tr(),
                            style: textStyle,
                          ),
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.push(
                                VerificationScreen(phone: email.text),
                              );
                            }
                          },
                        ),
                        100.H,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
