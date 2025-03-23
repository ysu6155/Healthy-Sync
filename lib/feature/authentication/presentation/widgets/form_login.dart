import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/constants/enum.dart';

import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/core/widgets/show_dialog.dart';
import 'package:healthy_sync/feature/authentication/data/models/request/register_params.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/login_cubit/login_state.dart';
import 'package:healthy_sync/feature/authentication/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'package:healthy_sync/feature/authentication/presentation/screens/signup/signup_screen.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';

class FormLogin extends StatelessWidget {
  final UserType userType;
  const FormLogin({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          context.pop();
          showErrorToast(context, state.error);
        } else if (state is LoginSuccess) {
        } else if (state is LoginLoading) {
          showLoadingDialog(context);
        }
      },
      child: Form(
        key: loginCubit.formKey,
        child: SingleChildScrollView(
          child: Column(
            spacing: 8.sp,
            children: [
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
                buildWhen:
                    (previous, current) =>
                        current is LoginPasswordVisibilityToggled,
                builder: (context, state) {
                  return CustomTextField(
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted:
                        (value) => loginCubit.login(
                          RegisterParams(
                            email: loginCubit.emailController.text,
                            password: loginCubit.passwordController.text,
                          ),
                          context,
                        ),
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
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BlocBuilder<LoginCubit, LoginState>(
                        buildWhen:
                            (previous, current) =>
                                current is LoginRememberMeToggled,
                        builder: (context, state) {
                          return Transform.scale(
                            scale: ResponsiveHelper.isMobile(context) ? 1 : 1.5,
                            child: Checkbox(
                              value: loginCubit.rememberMe,
                              onChanged: (value) {
                                loginCubit.toggleRememberMe(value ?? false);
                              },
                            ),
                          );
                        },
                      ),
                      Text(
                        LocaleKeys.rememberMe.tr(),
                        style: textStyleBody.copyWith(color: AppColor.black),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      context.push(ForgotPasswordScreen());
                    },
                    child: Text(
                      " ${LocaleKeys.forgotPassword.tr()}",
                      style: textStyleBody.copyWith(color: AppColor.black),
                    ),
                  ),
                ],
              ),
              CustomButton(
                name: Text(LocaleKeys.login.tr(), style: textStyleTitle),
                onTap: () {
                  loginCubit.login(
                    RegisterParams(
                      email: loginCubit.emailController.text,
                      password: loginCubit.passwordController.text,
                    ),
                    context,
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.dontHaveAnAccount.tr(),
                    style: textStyle.copyWith(color: AppColor.black),
                  ),
                  TextButton(
                    onPressed: () {
                      context.push(SignUpScreen(userType: userType));
                    },
                    child: Text(
                      LocaleKeys.signUp.tr(),
                      style: textStyle.copyWith(color: AppColor.main),
                    ),
                  ),
                ],
              ),
              60.H,
            ],
          ),
        ),
      ),
    );
  }
}
