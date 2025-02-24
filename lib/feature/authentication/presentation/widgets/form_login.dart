import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/login_cubit/login_state.dart';
import 'package:healthy_sync/feature/authentication/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'package:healthy_sync/feature/authentication/presentation/screens/signup/signup_screen.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);
    return Form(
      key: loginCubit.formKey,
      child: SingleChildScrollView(
        child: Column(spacing: 8.sp, children: [
          16.H,
          CustomTextField(
            textInputAction: TextInputAction.next,
            controller: loginCubit.emailController,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: LocaleKeys.enterYourEmailOrPhone.tr(),
            keyboardType: TextInputType.emailAddress,
            labelText: LocaleKeys.emailPhone.tr(),
            labelStyle: TextStyle(
              color: AppColor.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.emailIsRequired.tr();
              }
              return null;
            },
          ),
          8.H,
          BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (previous, current) =>
                  current is LoginPasswordVisibilityToggled,
              builder: (context, state) {
                return CustomTextField(
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) => loginCubit.login(context),
                  controller: loginCubit.passwordController,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  keyboardType: TextInputType.visiblePassword,
                  labelText: LocaleKeys.password.tr(),
                  labelStyle: TextStyle(
                    color: AppColor.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                  hintText: "*" * 8,
                  isPassword: true,
                  isPasswordVisible: loginCubit.isPasswordVisible,
                  togglePasswordVisibility: () {
                    loginCubit.togglePasswordVisibility();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.passwordIsRequired.tr();
                    }
                    return null;
                  },
                );
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (previous, current) =>
                          current is LoginRememberMeToggled,
                      builder: (context, state) {
                        return Checkbox(
                          value: loginCubit.rememberMe,
                          onChanged: (value) {
                            loginCubit.toggleRememberMe(value ?? false);
                          },
                        );
                      }),
                  Text(
                    LocaleKeys.rememberMe.tr(),
                    style: textButtonStyle.copyWith(
                        color: AppColor.black, fontSize: 14.sp),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  context.push(ForgotPasswordScreen());
                },
                child: Text(
                  " ${LocaleKeys.forgotPassword.tr()}?",
                  style: TextStyle(
                      color: AppColor.main, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (previous, current) =>
                  current is LoginLoading ||
                  current is LoginError ||
                  current is LoginSuccess,
              builder: (context, state) {
                if (state is LoginLoading) {
                  return CircularProgressIndicator();
                } else if (state is LoginError) {
                  return Text(
                    "state.error",
                    style: TextStyle(
                      color: AppColor.red,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                } else {
                  return CustomButton(
                    name: Text(
                      LocaleKeys.login.tr(),
                      style: textButtonStyle,
                    ),
                    onTap: () {
                      loginCubit.login(context);
                    },
                  );
                }
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(LocaleKeys.dontHaveAnAccount.tr()),
              TextButton(
                onPressed: () {
                  context.push(SignUpScreen());
                },
                child: Text(
                  LocaleKeys.signUp.tr(),
                  style: TextStyle(
                      color: AppColor.main, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          60.H,
        ]),
      ),
    );
  }
}
