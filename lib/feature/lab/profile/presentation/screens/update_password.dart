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
import 'package:healthy_sync/feature/authentication/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/profile/cubit/profile_cubit.dart';
import 'package:lottie/lottie.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.mainPink),
          onPressed: () {
            context.pop();
            context.read<ProfileCubit>().getProfileData();
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
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is ProfileUpdateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<ProfileCubit>();

            return ListView(
              children: [
                Gap(20),
                Center(
                  child: Lottie.asset(AppAssets.passwordImage, height: 150.sp),
                ),
                Gap(25),
                CustomTextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  controller: cubit.currentPasswordController,
                  hintText: LocaleKeys.oldPassword.tr(),
                  isPassword: true,
                ),
                Gap(26),
                CustomTextField(
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
                  keyboardType: TextInputType.visiblePassword,
                  controller: cubit.newPasswordController,
                  hintText: LocaleKeys.newPassword.tr(),
                  isPassword: true,
                ),
                Gap(26),
                CustomTextField(
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
                  keyboardType: TextInputType.visiblePassword,
                  controller: cubit.confirmPasswordController,
                  hintText: LocaleKeys.confirmNewPassword.tr(),
                  isPassword: true,
                ),
                Gap(40),
                state is ProfileUpdateLoading
                    ? Center(child: CircularProgressIndicator())
                    : CustomButton(
                        name: LocaleKeys.changePassword.tr(),
                        onTap: () {
                          cubit.updatePassword();
                        },
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
