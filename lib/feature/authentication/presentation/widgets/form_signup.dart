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
import 'package:healthy_sync/feature/authentication/presentation/cubit/signup_cubit/signup_cubit.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/signup_cubit/signup_state.dart';
import 'package:healthy_sync/feature/authentication/presentation/widgets/custom_dropdown.dart';
import 'package:healthy_sync/feature/authentication/presentation/screens/login/login_screen.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/feature/doctors/home_nav/presentation/screens/doctor_home_nav.dart';
import 'package:healthy_sync/feature/lab/home_nav/presentation/screens/lab_nav.dart';
import 'package:healthy_sync/feature/patients/home_nav/presentation/screens/patient_home_nav.dart';

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
          if (widget.userType == UserType.doctor) {
            context.pushReplacement(const DoctorHomeNavScreen());
          } else if (widget.userType == UserType.patient) {
            context.pushReplacement(const PatientHomeNavScreen());
          } else if (widget.userType == UserType.lab) {
            context.pushReplacement(const LabHomeNavScreen());
          }
        } else if (state is SignUpError) {
          Navigator.pop(context);
          showErrorToast(context, state.error);
        }
      },
      child: Form(
        key: signUpCubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            name(signUpCubit),
            16.H,
            email(signUpCubit),
            16.H,
            UserSpecificContent(
              userType: widget.userType,
              doctorWidget: specialization(signUpCubit),
            ),
            UserSpecificContent(
              userType: widget.userType,
              otherWidget: age(signUpCubit),
            ),
            phone(signUpCubit),
            16.H,
            selectCity(signUpCubit),
            16.H,
            genderWidget(signUpCubit),
            passwords(signUpCubit),
            16.H,
            UserSpecificContent(
              userType: widget.userType,
              otherWidget: chronicDiseases(signUpCubit, context),
            ),
            16.H,
            checkBox(signUpCubit),
            12.H,
            CustomButton(
              name: LocaleKeys.signUp.tr(),
              onTap: () => signUpCubit.register(
                RegisterParams(
                  email: signUpCubit.emailController.text,
                  password: signUpCubit.passwordController.text,
                  name: signUpCubit.nameController.text,
                  passwordConfirmation:
                      signUpCubit.confirmPasswordController.text,
                  role: widget.userType.name,
                  phone: signUpCubit.phoneController.text,
                  //  specialization: signUpCubit.specializationController.text,
                  gender: signUpCubit.selectedGender,
                  dateOfBirth: signUpCubit.ageController.text,
                  //profilePhoto: signUpCubit.profilePhotoController.text,
                  //chronicDiseases: signUpCubit.selectedDiseases,
                  //city: signUpCubit.selectedCity,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.alreadyHaveAnAccount.tr(),
                  style: TextStyles.font12DarkBlueW400,
                ),
                TextButton(
                  onPressed: () => context.pushReplacement(
                    LoginScreen(userType: widget.userType),
                  ),
                  child: Text(
                    LocaleKeys.login.tr(),
                    style: TextStyles.font12BlueW400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column name(SignUpCubit signUpCubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.name.tr(), style: TextStyles.font16DarkBlueW500),
        8.H,
        CustomTextField(
          controller: signUpCubit.nameController,
          hintText: LocaleKeys.youssifShaban.tr(),
          validator: (value) =>
              value!.isEmpty ? LocaleKeys.nameIsRequired.tr() : null,
        ),
      ],
    );
  }

  Column email(SignUpCubit signUpCubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.email.tr(), style: TextStyles.font16DarkBlueW500),
        8.H,
        CustomTextField(
          controller: signUpCubit.emailController,
          hintText: LocaleKeys.exampleEmail.tr(),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return LocaleKeys.emailIsRequired.tr();
            }
            return null;
          },
        ),
      ],
    );
  }

  Column age(SignUpCubit signUpCubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.age.tr(), style: TextStyles.font16DarkBlueW500),
        8.H,
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            if (pickedDate != null) {
              signUpCubit.ageController.text =
                  "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
            }
          },
          child: AbsorbPointer(
            child: CustomTextField(
              controller: signUpCubit.ageController,
              hintText: LocaleKeys.age.tr(),
              keyboardType: TextInputType.datetime,
            ),
          ),
        ),
        16.H,
      ],
    );
  }

  Column specialization(SignUpCubit signUpCubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.specialization.tr(),
          style: TextStyles.font16DarkBlueW500,
        ),
        8.H,
        BlocBuilder<SignUpCubit, SignUpState>(
          buildWhen: (previous, current) => current is SpecializationSelected,
          builder: (context, state) {
            return CustomDropdown(
              value: signUpCubit.selectedSpecialization,
              hint: LocaleKeys.selectSpecialization.tr(),
              onChanged: signUpCubit.selectSpecialization,
              validator: (value) => value == null
                  ? LocaleKeys.specializationIsRequired.tr()
                  : null,
              items: signUpCubit.getSpecializations().map((specialization) {
                return DropdownMenuItem(
                  value: specialization,
                  child: Text(specialization),
                );
              }).toList(),
            );
          },
        ),
        16.H,
      ],
    );
  }

  Column phone(SignUpCubit signUpCubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.phone.tr(), style: TextStyles.font16DarkBlueW500),
        8.H,
        CustomTextField(
          controller: signUpCubit.phoneController,
          hintText: LocaleKeys.youssifPhone.tr(),
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Column selectCity(SignUpCubit signUpCubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.city.tr(), style: TextStyles.font16DarkBlueW500),
        8.H,
        BlocBuilder<SignUpCubit, SignUpState>(
          buildWhen: (previous, current) => current is CitySelected,
          builder: (context, state) {
            return CustomDropdown(
              value: signUpCubit.selectedCity,
              hint: LocaleKeys.cityHint.tr(),
              onChanged: signUpCubit.selectCity,
              items: signUpCubit
                  .getCities(context.locale.languageCode)
                  .map(
                    (city) => DropdownMenuItem(value: city, child: Text(city)),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  Column passwords(SignUpCubit signUpCubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.password.tr(), style: TextStyles.font16DarkBlueW500),
        8.H,
        BlocBuilder<SignUpCubit, SignUpState>(
          buildWhen: (previous, current) =>
              current is PasswordVisibilityToggled,
          builder: (context, state) {
            return CustomTextField(
              controller: signUpCubit.passwordController,
              hintText: "*" * 8,
              isPassword: true,
              isPasswordVisible: signUpCubit.isPasswordVisible,
              togglePasswordVisibility: signUpCubit.togglePasswordVisibility,
              validator: (value) =>
                  value!.isEmpty ? LocaleKeys.passwordIsRequired.tr() : null,
            );
          },
        ),
        16.H,
        Text(
          LocaleKeys.confirmPassword.tr(),
          style: TextStyles.font16DarkBlueW500,
        ),
        8.H,
        BlocBuilder<SignUpCubit, SignUpState>(
          buildWhen: (previous, current) =>
              current is PasswordVisibilityToggled,
          builder: (context, state) {
            return CustomTextField(
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
      ],
    );
  }

  BlocBuilder<SignUpCubit, SignUpState> checkBox(SignUpCubit signUpCubit) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => current is TermsAgreementToggled,
      builder: (context, state) {
        return Row(
          children: [
            Transform.scale(
              scale: ResponsiveHelper.isMobile(context) ? 1 : 1.5,
              child: Checkbox(
                activeColor: AppColor.mainPink,
                value: signUpCubit.isAgreedToTerms,
                onChanged: (bool? value) {
                  signUpCubit.toggleTermsAgreement(value ?? false);
                },
              ),
            ),
            Text(
              LocaleKeys.iAgreeToTermsAndConditions.tr(),
              style: TextStyles.font16DarkBlueW500,
            ),
          ],
        );
      },
    );
  }

  Column chronicDiseases(SignUpCubit signUpCubit, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.chronicDiseases.tr(),
          style: TextStyles.font16DarkBlueW500,
        ),
        8.H,
        Wrap(
          spacing: 8.0.sp,
          children: signUpCubit.selectedDiseases.map((disease) {
            return Chip(
              label: Text(disease, style: TextStyles.font16DarkBlueW500),
              backgroundColor: AppColor.mainBlue,
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
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return signUpCubit
                .getChronicDiseases(context.locale.languageCode)
                .where((disease) => disease.contains(textEditingValue.text));
          },
          onSelected: (String selection) {
            if (!signUpCubit.selectedDiseases.contains(selection)) {
              setState(() {
                signUpCubit.selectedDiseases.add(selection);
              });
            }
            signUpCubit.diseaseController.clear();
          },
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            return CustomTextField(
              hintText: LocaleKeys.Diabetes.tr(),
              controller: signUpCubit.diseaseController,
              focusNode: focusNode,
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
    );
  }

  Column genderWidget(SignUpCubit signUpCubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.gender.tr(), style: TextStyles.font16DarkBlueW500),
        8.H,
        BlocBuilder<SignUpCubit, SignUpState>(
          buildWhen: (previous, current) => current is GenderSelected,
          builder: (context, state) {
            return CustomDropdown(
              value: signUpCubit.selectedGender,
              hint: LocaleKeys.maleGender.tr(),
              onChanged: signUpCubit.selectGender,
              validator: (value) =>
                  value == null ? LocaleKeys.genderIsRequired.tr() : null,
              items: [
                DropdownMenuItem(
                  value: "male",
                  child: Text(LocaleKeys.maleGender.tr()),
                ),
                DropdownMenuItem(
                  value: "female",
                  child: Text(LocaleKeys.femaleGender.tr()),
                ),
              ],
            );
          },
        ),
        16.H,
      ],
    );
  }
}

class UserSpecificContent extends StatelessWidget {
  final UserType userType;
  final Widget? doctorWidget;
  final Widget? otherWidget;

  const UserSpecificContent({
    super.key,
    required this.userType,
    this.doctorWidget,
    this.otherWidget,
  });

  @override
  Widget build(BuildContext context) {
    return userType == UserType.doctor
        ? doctorWidget ?? SizedBox()
        : otherWidget ?? SizedBox();
  }
}
