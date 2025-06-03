import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';
import 'package:healthy_sync/feature/authentication/presentation/verification/cubit/verification_cubit.dart';

import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/feature/authentication/presentation/verification/screen/verification_screen.dart';

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
      backgroundColor: AppColor.white,
      appBar: AppBar(
        toolbarHeight: 48.sp,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColor.white, size: 24.sp),
        backgroundColor: AppColor.mainPink,
        title: Text(
          LocaleKeys.forgotPassword.tr(),
          style: TextStyles.font20WhiteBold,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 12.sp,
            children: [
              Image.asset(
                AppAssets.forgotPassword,
                width: 130.w,
                height: 130.sp,
                fit: BoxFit.cover,
              ),
              24.H,
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16.sp,
                  children: [
                    Text(
                      LocaleKeys.enterYourEmailOrPhone.tr(),
                      style: TextStyles.font16DarkBlueW500.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomTextField(
                      controller: email,
                      // labelText: LocaleKeys.emailPhone.tr(),
                      // labelStyle: TextStyles.font12DarkBlueW400,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: LocaleKeys.exampleEmail.tr(),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.emailIsRequired.tr();
                        }
                        return null;
                      },
                    ),
                    4.H,
                    CustomButton(
                      name: LocaleKeys.sendCode.tr(),
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.push(BlocProvider(
                            create: (context) => VerificationCubit(),
                            child: VerificationScreen(phone: email.text),
                          ));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ).paddingAll(16.sp),
        ),
      ),
    );
  }
}
