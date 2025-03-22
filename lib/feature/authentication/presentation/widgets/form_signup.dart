import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/enum/enum.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';
import 'package:healthy_sync/core/widgets/responsive_helper.dart';
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
import 'package:healthy_sync/feature/patients/presentation/screens/patient_home_nav.dart';

class FormSignUp extends StatefulWidget {
  final UserType userType;
  const FormSignUp({super.key, required this.userType});

  @override
  State<FormSignUp> createState() => _FormSignUpState();
}

class _FormSignUpState extends State<FormSignUp> {
  @override
  Widget build(BuildContext context) {
    SignUpCubit signUpCubit = BlocProvider.of<SignUpCubit>(context);
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          showLoadingDialog(context);
        } else if (state is SignUpSuccess) {
          Navigator.pop(context);
          context.pushAndRemoveUntil(PatientHomeNavScreen());
        } else if (state is SignUpError) {
          Navigator.pop(context);
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
                  validator:
                      (value) =>
                          value == null
                              ? LocaleKeys.accountTypeIsRequired.tr()
                              : null,
                  items: [
                    DropdownMenuItem(
                      value: "doctor",
                      child: Text(LocaleKeys.doctor.tr()),
                    ),
                    DropdownMenuItem(
                      value: "patient",
                      child: Text(LocaleKeys.patient.tr()),
                    ),
                    DropdownMenuItem(
                      value: "lab",
                      child: Text(LocaleKeys.lab.tr()),
                    ),
                    DropdownMenuItem(
                      value: "admin",
                      child: Text(LocaleKeys.admin.tr()),
                    ),
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
              validator:
                  (value) =>
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
              // validator: (value) {
              // if (value!.isEmpty) {
              //  return LocaleKeys.ageIsRequired.tr();
              //  }
              //if (int.tryParse(value) == null) {
              //return LocaleKeys.PleaseEnterAValidNumber.tr();
              // }
              //return null;
              //},
            ),
            16.H,
            CustomTextField(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              controller: signUpCubit.phoneController,
              hintText: LocaleKeys.youssifPhone.tr(),
              labelText: LocaleKeys.phone.tr(),
              keyboardType: TextInputType.phone,
              // validator: (value) {
              // if (value!.isEmpty) {
              // return LocaleKeys.phoneIsRequired.tr();
              //}
              //return null;
              //},
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
                  // validator:
                  //     (value) =>
                  //         value == null ? LocaleKeys.cityIsRequired.tr() : null,
                  items:
                      signUpCubit
                          .getCities(context.locale.languageCode)
                          .map(
                            (city) => DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            ),
                          )
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
                  validator:
                      (value) =>
                          value == null
                              ? LocaleKeys.genderIsRequired.tr()
                              : null,
                  items: [
                    DropdownMenuItem(
                      value: "Male",
                      child: Text(LocaleKeys.maleGender.tr()),
                    ),
                    DropdownMenuItem(
                      value: "Female",
                      child: Text(LocaleKeys.femaleGender.tr()),
                    ),
                  ],
                );
              },
            ),
            16.H,
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen:
                  (previous, current) => current is PasswordVisibilityToggled,
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
                  validator:
                      (value) =>
                          value!.isEmpty
                              ? LocaleKeys.passwordIsRequired.tr()
                              : null,
                );
              },
            ),
            16.H,
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen:
                  (previous, current) => current is PasswordVisibilityToggled,
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
              },
            ),
            Column(
              children: [
                16.H,

                Wrap(
                  spacing: 8.0.sp,
                  children:
                      signUpCubit.selectedDiseases.map((disease) {
                        return Chip(
                          label: Text(disease, style: textStyleBody),
                          backgroundColor: AppColor.secondary,
                          deleteIcon: Icon(
                            Icons.close,
                            size: 18.sp,
                            color: AppColor.white,
                          ),
                          onDeleted: () {
                            setState(() {
                              signUpCubit.selectedDiseases.remove(disease);
                            });
                          },
                        );
                      }).toList(),
                ),
                10.H,
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    }
                    return signUpCubit
                        .getChronicDiseases(context.locale.languageCode)
                        .where(
                          (disease) => disease.contains(textEditingValue.text),
                        );
                  },
                  onSelected: (String selection) {
                    if (!signUpCubit.selectedDiseases.contains(selection)) {
                      setState(() {
                        signUpCubit.selectedDiseases.add(selection);
                      });
                    }
                    signUpCubit.diseaseController.clear();
                  },
                  fieldViewBuilder: (
                    context,
                    controller,
                    focusNode,
                    onFieldSubmitted,
                  ) {
                    return CustomTextField(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: LocaleKeys.Diabetes.tr(),
                      controller: signUpCubit.diseaseController,
                      focusNode: focusNode,

                      labelText: LocaleKeys.enterChronicDiseases.tr(),

                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty &&
                            !signUpCubit.selectedDiseases.contains(value)) {
                          setState(() {
                            signUpCubit.selectedDiseases.add(value);
                          });
                          signUpCubit.diseaseController.clear();
                        }
                      },
                    );
                  },
                ),
              ],
            ),

            16.H,
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen:
                  (previous, current) => current is TermsAgreementToggled,
              builder: (context, state) {
                return Row(
                  children: [
                    Transform.scale(
                      scale: ResponsiveHelper.isMobile(context) ? 1 : 1.5,
                      child: Checkbox(
                        value: signUpCubit.isAgreedToTerms,
                        onChanged: (bool? value) {
                          signUpCubit.toggleTermsAgreement(value ?? false);
                        },
                      ),
                    ),
                    Text(
                      LocaleKeys.iAgreeToTermsAndConditions.tr(),
                      style: textStyleBody.copyWith(color: AppColor.black),
                    ),
                  ],
                );
              },
            ),
            12.H,
            CustomButton(
              name: Text(LocaleKeys.signUp.tr(), style: textStyleTitle),
              onTap:
                  () => signUpCubit.register(
                    RegisterParams(
                      email: signUpCubit.emailController.text,
                      password: signUpCubit.passwordController.text,
                      name: signUpCubit.nameController.text,
                      passwordConfirmation:
                          signUpCubit.confirmPasswordController.text,
                      role: signUpCubit.selectedAccountType,
                    ),
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.alreadyHaveAnAccount.tr(),
                  style: textStyleBody.copyWith(color: AppColor.black),
                ),
                TextButton(
                  onPressed:
                      () =>
                          context.push(LoginScreen(userType: widget.userType)),

                  child: Text(
                    LocaleKeys.login.tr(),
                    style: textStyleBody.copyWith(color: AppColor.main),
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
