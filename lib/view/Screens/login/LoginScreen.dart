import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/generated/l10n.dart';
import 'package:healthy_sync/view/Screens/login/Widgets/FormLogin.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
                SizedBox(
                  height: 50.sp,
                ),
                Text(
                  S.of(context).welcomeToHealthySync,
                  style: TextStyle(
                      color: AppColor.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  S.of(context).loginToYourAccount,
                  style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp),
                ),
                SizedBox(
                  height:30.sp,
                ),
                Container(
                  padding: EdgeInsets.all(24.r),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r)),
                  ),
                  child:FormLogin(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
