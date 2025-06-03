import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';
import 'package:healthy_sync/feature/authentication/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:healthy_sync/feature/authentication/presentation/reset_password/cubit/reset_password_state.dart';
import 'package:lottie/lottie.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColor.mainPink),
            onPressed: () {
              context.pop();
            },
          ),
          centerTitle: true,
          title: Text(
            LocaleKeys.changePassword.tr(),
            style: TextStyles.font20WhiteBold.copyWith(color: AppColor.black),
          ),
          backgroundColor: AppColor.white,
        ),
        body: Padding(
          padding: EdgeInsets.all(20.sp),
          child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
            listener: (context, state) {
              if (state is ResetPasswordSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );
                context.pop();
              } else if (state is ResetPasswordError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<ResetPasswordCubit>();

              return Form(
                key: cubit.formKey,
                child: ListView(
                  children: [
                    const Gap(20),
                    Center(
                      child:
                          Lottie.asset(AppAssets.passwordImage, height: 150.sp),
                    ),
                    const Gap(25),
                    Text(LocaleKeys.newPassword.tr(),
                        style: TextStyles.font16DarkBlueW500
                            .copyWith(fontWeight: FontWeight.bold)),
                    const Gap(15),
                    CustomTextField(
                      isPasswordVisible: cubit.isPasswordVisible,
                      togglePasswordVisibility: () {
                        cubit.togglePasswordVisibility();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.passwordIsRequired.tr();
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      controller: cubit.newPasswordController,
                      hintText: LocaleKeys.newPassword.tr(),
                      isPassword: true,
                    ),
                    const Gap(26),
                    Text(LocaleKeys.confirmNewPassword.tr(),
                        style: TextStyles.font16DarkBlueW500
                            .copyWith(fontWeight: FontWeight.bold)),
                    const Gap(15),
                    CustomTextField(
                      isPasswordVisible: cubit.isPasswordVisible,
                      togglePasswordVisibility: () {
                        cubit.togglePasswordVisibility();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.passwordIsRequired.tr();
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      controller: cubit.confirmPasswordController,
                      hintText: LocaleKeys.confirmNewPassword.tr(),
                      isPassword: true,
                    ),
                    const Gap(40),
                    state is ResetPasswordLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            name: LocaleKeys.changePassword.tr(),
                            onTap: () {
                              cubit.updatePassword();
                            },
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
