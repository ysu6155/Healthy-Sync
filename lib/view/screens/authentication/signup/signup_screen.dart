import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/view/screens/authentication/signup/Widgets/form_signup.dart';
import 'package:healthy_sync/view_model/cubit/auth_cubit/signup_cubit/signup_cubit.dart';
import 'package:healthy_sync/view_model/translations/locale_keys.g.dart';
import 'package:healthy_sync/view_model/utils/app_color.dart';
import 'package:healthy_sync/view_model/utils/extensions.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            gradient: AppColor.primaryGradient,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                 90.H,
                 Text(
                   LocaleKeys.createAccount.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                 Text(
                   LocaleKeys.joinNow.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                30.H,
                Container(
                  padding:  EdgeInsets.all(24.sp),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius:  BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                  child: BlocProvider(
                      create: (context) => SignUpCubit(),
                      child: FormSignUp()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}