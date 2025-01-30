import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/generated/l10n.dart';
import 'package:healthy_sync/view/Screens/ForgotPassword/ForgotPasswordScreen.dart';
import 'package:healthy_sync/view/Screens/Layout/LayoutScreen.dart';
import 'package:healthy_sync/view/Screens/signup/SignUpScraeen.dart';
import 'package:healthy_sync/view/Widgets/Button.dart';
import 'package:healthy_sync/view/Widgets/CustomTextField.dart';
import 'package:healthy_sync/view_model/Themes/Themedata.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  bool isPasswordVisible = false;
  bool isOption1Selected = false;
  @override
  Widget build(BuildContext context) {
    return Form (
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          spacing: 8.sp,
            children: [
              SizedBox(
                height: 16.sp,
              ),
              CustomTextField(
                controller: email,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: S.of(context).enterYourEmailOrPhone,
                keyboardType: TextInputType.emailAddress,
                labelText: S.of(context).emailPhone,
                labelStyle: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),

                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).emailIsRequired;
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.sp),
              CustomTextField(
                controller: password,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                keyboardType: TextInputType.text,
                labelText: S.of(context).password,
                labelStyle: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),

                hintText: "*"*8,
                isPassword: true,
                isPasswordVisible: isPasswordVisible,
                togglePasswordVisibility: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).passwordIsRequired;
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isOption1Selected,
                        onChanged: (value) {
                          setState(() {
                            isOption1Selected = value!;
                          }
                          );
                        },
                      ),
                      Text(S.of(context).rememberMe,style:textButtonStyle.copyWith(
                        color: AppColor.black,
                        fontSize: 14.sp
                      ),),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                     " ${S.of(context).forgotPassword}?",
                      style: TextStyle(
                          color: AppColor.main,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Button(
                name: Text(S.of(context).login,style: textButtonStyle,),
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TapBarScreen(),
                      ),
                          (route) => false,
                    );
                  }
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).dontHaveAnAccount),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      S.of(context).signUp,
                      style: TextStyle(
                          color: AppColor.main,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ]),
      ),

    );
  }
}
