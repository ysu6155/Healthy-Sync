import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/view/Screens/authentication/login/Widgets/form_login.dart';
import 'package:healthy_sync/view_model/cubit/auth_cubit/login_cubit/login_cubit.dart';
import 'package:healthy_sync/view_model/translations/locale_keys.g.dart';
import 'package:healthy_sync/view_model/utils/app_color.dart';
import 'package:healthy_sync/view_model/utils/extensions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         // backgroundColor: AppColor.main,
      body: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            gradient: AppColor.primaryGradient,
          ),
          child: SingleChildScrollView(
            child: Column(
              spacing: 8.sp,
              children: [
              50.H,
                Text(
                  LocaleKeys.welcomeToHealthySync.tr(),
                  style: TextStyle(
                      color: AppColor.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  LocaleKeys.loginToYourAccount.tr(),
                  style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp),
                ),
              30.H,
                Container(
                  padding: EdgeInsets.all(24.r),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r)),
                  ),
                  child:BlocProvider(
                      create: (context) => LoginCubit(),
                      child: FormLogin()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
