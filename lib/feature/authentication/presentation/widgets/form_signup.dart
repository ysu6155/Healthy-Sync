import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';
import 'package:healthy_sync/core/widgets/show_dialog.dart';
import 'package:healthy_sync/feature/authentication/data/models/request/register_params.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/signup_cubit/signup_cubit.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/signup_cubit/signup_state.dart';
import 'package:healthy_sync/feature/authentication/presentation/widgets/custom_dropdown.dart';
import 'package:healthy_sync/feature/authentication/presentation/screens/login/login_screen.dart';
import 'package:healthy_sync/core/Themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/feature/layout/presentation/screens/layout/layout_screen.dart';


class FormSignUp extends StatelessWidget {
  const FormSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpCubit signUpCubit = BlocProvider.of<SignUpCubit>(context);
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
           showLoadingDialog(context);
        } else if (state is SignUpSuccess) {
        
          Navigator.pop(context); // إغلاق الـ Dialog لو مفتوح
          context.pushAndRemoveUntil(TapBarScreen());
        } else if (state is SignUpError) {
          Navigator.pop(context); // إغلاق الـ Dialog لو مفتوح
          showErrorToast(context, state.error);

        }
      },
      child: Form(
        key: signUpCubit.formKey,
        child: Column(
          children: [
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (previous, current) => current is AccountTypeSelected,
              builder: (context, state) {
                return CustomDropdown(
                  labelText: LocaleKeys.accountType.tr(),
                  value: signUpCubit.selectedAccountType,
                  hint: LocaleKeys.patient.tr(),
                  onChanged: signUpCubit.selectAccountType,
                  validator: (value) => value == null
                      ? LocaleKeys.accountTypeIsRequired.tr()
                      : null,
                  items: [
                    DropdownMenuItem(
                        value: "Doctor", child: Text(LocaleKeys.doctor.tr())),
                    DropdownMenuItem(
                        value: "Patient", child: Text(LocaleKeys.patient.tr())),
                    DropdownMenuItem(
                        value: "Lab", child: Text(LocaleKeys.lab.tr())),
                    DropdownMenuItem(
                        value: "Admin", child: Text(LocaleKeys.admin.tr())),
                  ],
                );
              },
            ),
            16.H,
            CustomTextField(
              controller: signUpCubit.nameController,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: LocaleKeys.youssifShaban.tr(),
              labelText: LocaleKeys.name.tr(),
              validator: (value) =>
                  value!.isEmpty ? LocaleKeys.nameIsRequired.tr() : null,
            ),
            16.H,
            CustomTextField(
              controller: signUpCubit.emailController,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: LocaleKeys.exampleEmail.tr(),
              labelText: LocaleKeys.email.tr(),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return LocaleKeys.emailIsRequired.tr();
                }
                return null;
              },
            ),
            16.H,
            CustomTextField(
              controller: signUpCubit.ageController,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: LocaleKeys.youssifAge.tr(),
              labelText: LocaleKeys.age.tr(),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return LocaleKeys.ageIsRequired.tr();
                }
                if (int.tryParse(value) == null) {
                  return LocaleKeys.PleaseEnterAValidNumber.tr();
                }
                return null;
              },
            ),
            16.H,
            CustomTextField(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              controller: signUpCubit.phoneController,
              hintText: LocaleKeys.youssifPhone.tr(),
              labelText: LocaleKeys.phone.tr(),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return LocaleKeys.phoneIsRequired.tr();
                }
                return null;
              },
            ),
            16.H,
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (previous, current) => current is CitySelected,
              builder: (context, state) {
                return CustomDropdown(
                  labelText: LocaleKeys.city.tr(),
                  value: signUpCubit.selectedCity,
                  hint: LocaleKeys.cityHint.tr(),
                  onChanged: signUpCubit.selectCity,
                  validator: (value) =>
                      value == null ? LocaleKeys.cityIsRequired.tr() : null,
                  items: signUpCubit.cities
                      .map((city) =>
                          DropdownMenuItem(value: city, child: Text(city)))
                      .toList(),
                );
              },
            ),
            16.H,
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (previous, current) => current is GenderSelected,
              builder: (context, state) {
                return CustomDropdown(
                  labelText: LocaleKeys.gender.tr(),
                  value: signUpCubit.selectedGender,
                  hint: LocaleKeys.maleGender.tr(),
                  onChanged: signUpCubit.selectGender,
                  validator: (value) =>
                      value == null ? LocaleKeys.genderIsRequired.tr() : null,
                  items: [
                    DropdownMenuItem(
                        value: "Male", child: Text(LocaleKeys.maleGender.tr())),
                    DropdownMenuItem(
                        value: "Female",
                        child: Text(LocaleKeys.femaleGender.tr())),
                  ],
                );
              },
            ),
            16.H,
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (previous, current) =>
                  current is PasswordVisibilityToggled,
              builder: (context, state) {
                return CustomTextField(
                  labelText: LocaleKeys.password.tr(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  controller: signUpCubit.passwordController,
                  hintText: "*" * 8,
                  isPassword: true,
                  isPasswordVisible: signUpCubit.isPasswordVisible,
                  togglePasswordVisibility:
                      signUpCubit.togglePasswordVisibility,
                  validator: (value) => value!.isEmpty
                      ? LocaleKeys.passwordIsRequired.tr()
                      : null,
                );
              },
            ),
            16.H,
            BlocBuilder<SignUpCubit, SignUpState>(
                buildWhen: (previous, current) =>
                    current is PasswordVisibilityToggled,
                builder: (context, state) {
                  return CustomTextField(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: LocaleKeys.confirmPassword.tr(),
                    controller: signUpCubit.confirmPasswordController,
                    hintText: "*" * 8,
                    isPassword: true,
                    isPasswordVisible: signUpCubit.isPasswordVisible,
                    togglePasswordVisibility: () {
                      signUpCubit.togglePasswordVisibility();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.confirmPasswordIsRequired.tr();
                      }
                      if (value != signUpCubit.passwordController.text) {
                        return LocaleKeys.PasswordDoesNotMatch.tr();
                      }
                      return null;
                    },
                  );
                }),
            16.H,
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (previous, current) =>
                  current is TermsAgreementToggled,
              builder: (context, state) {
                return Row(
                  children: [
                    Checkbox(
                      value: signUpCubit.isAgreedToTerms,
                      onChanged: (bool? value) {
                        signUpCubit.toggleTermsAgreement(value ?? false);
                      },
                    ),
                    Text(LocaleKeys.iAgreeToTermsAndConditions.tr(),
                        style: TextStyle(fontSize: 12.sp)),
                  ],
                );
              },
            ),
            12.H,
            CustomButton(
              name: Text(LocaleKeys.signUp.tr(), style: textButtonStyle),
              onTap: () => signUpCubit.register(
                RegisterParams(
                    email: signUpCubit.emailController.text,
                    password: signUpCubit.passwordController.text,
                    name: signUpCubit.nameController.text,
                    passwordConfirmation:
                        signUpCubit.confirmPasswordController.text),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocaleKeys.alreadyHaveAnAccount.tr(),
                    style: TextStyle(fontSize: 12.sp)),
                TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen())),
                  child: Text(
                    LocaleKeys.login.tr(),
                    style: textButtonStyle.copyWith(
                      color: AppColor.main,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
