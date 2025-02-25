import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:healthy_sync/feature/authentication/presentation/widgets/form_login.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.login.tr(),
          style: TextStyle(
            color: AppColor.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColor.white),
        backgroundColor: AppColor.main,
      ),
      // backgroundColor: AppColor.main,
      body: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(color: AppColor.main),
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
                  child: BlocProvider(
                      create: (context) => LoginCubit(), child: FormLogin()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
