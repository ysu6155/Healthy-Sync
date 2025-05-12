import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/constants/enum.dart';
import 'package:healthy_sync/core/themes/styles.dart';

import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/core/widgets/show_dialog.dart';
import 'package:healthy_sync/feature/authentication/data/models/request/register_params.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/login_cubit/login_state.dart';
import 'package:healthy_sync/feature/authentication/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'package:healthy_sync/feature/authentication/presentation/screens/signup/signup_screen.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/feature/lab/home_nav/presentation/screens/lab_nav.dart';
import 'package:healthy_sync/feature/patients/home_nav/presentation/screens/patient_home_nav.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.sp,
            children: [
              16.H,
              Text(LocaleKeys.email.tr(), style: TextStyles.font20DarkBlueBold),
              CustomTextField(
                textInputAction: TextInputAction.next,
                controller: loginCubit.emailController,
                hintText: LocaleKeys.exampleEmail.tr(),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.emailIsRequired.tr();
                  }
                  return null;
                },
              ),
              Text(
                LocaleKeys.password.tr(),
                style: TextStyles.font16DarkBlueW500,
              ),
              BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (previous, current) =>
                    current is LoginPasswordVisibilityToggled,
                builder: (context, state) {
                  return CustomTextField(
                    borderColor: AppColor.mainPink,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) => loginCubit.login(
                      RegisterParams(
                        email: loginCubit.emailController.text,
                        password: loginCubit.passwordController.text,
                      ),
                      context,
                    ),
                    controller: loginCubit.passwordController,
                    keyboardType: TextInputType.visiblePassword,
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
                        buildWhen: (previous, current) =>
                            current is LoginRememberMeToggled,
                        builder: (context, state) {
                          return Transform.scale(
                            scale: ResponsiveHelper.isMobile(context) ? 1 : 1.5,
                            child: Checkbox(
                              activeColor: AppColor.mainPink,
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
                        style: TextStyles.font16DarkBlueW500,
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      context.push(ForgotPasswordScreen());
                    },
                    child: Row(
                      children: [
                        Text(
                          LocaleKeys.forgotPassword.tr(),
                          style: TextStyles.font16DarkBlueW500,
                        ),
                        Text(
                          LocaleKeys.Q.tr(),
                          style: TextStyles.font16PinkW500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CustomButton(
                name: LocaleKeys.login.tr(),
                onTap: () {
                   context.pushAndRemoveUntil(const PatientHomeNavScreen());
                  // loginCubit.login(
                  //   RegisterParams(
                  //     phone: loginCubit.emailController.text,
                  //     password: loginCubit.passwordController.text,
                  //   ),
                  //   context,
                  // );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.dontHaveAnAccount.tr(),
                    style: TextStyles.font12DarkBlueW400,
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushReplacement(SignUpScreen(userType: userType));
                    },
                    child: Text(
                      LocaleKeys.signUp.tr(),
                      style: TextStyles.font12BlueW400,
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
