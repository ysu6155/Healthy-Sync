import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/generated/l10n.dart';

import 'package:healthy_sync/view/Screens/home/HomeScreen.dart';
import 'package:healthy_sync/view/Widgets/Button.dart';
import 'package:healthy_sync/view_model/Themes/Themedata.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';
import '../../login/LoginScreen.dart';

import 'CityDropdown.dart';
import '../../../Widgets/CustomTextField.dart';

class FormSiginUp extends StatefulWidget {
  const FormSiginUp({super.key});

  @override
  State<FormSiginUp> createState() => _FormSiginUpState();
}

class _FormSiginUpState extends State<FormSiginUp> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController age = TextEditingController();
  String? selectedGender;
  bool isPasswordVisible = false;
  bool isOption1Selected = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: name,
            hintText: S.of(context).name,
            validator: (value) {
              if (value!.isEmpty) {
                return S.of(context).nameIsRequired;
              }
              return null;
            },
          ),
           SizedBox(height: 16.sp),
          CustomTextField(
            controller: phone,
            hintText: S.of(context).phone,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return S.of(context).phoneIsRequired;
              }
              return null;
            },
          ),
           SizedBox(height: 16.sp),
          CityForm(),
           SizedBox(height: 16.sp),
          CustomTextField(
            controller: age,
            hintText: S.of(context).age,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return S.of(context).ageIsRequired;
              }
              if (int.tryParse(value) == null) {
                return S.of(context).PleaseEnterAValidNumber;
              }
              return null;
            },
          ),
           SizedBox(height: 16.sp),
          DropdownButtonFormField<String>(
            iconSize: 25.sp,
            hint: Text(S.of(context).gender,style: TextStyle(
                fontSize: 14.sp
            ),),
            items:  [
              DropdownMenuItem(
                value: "Male",
                child: Row(
                  children: [
                    Icon(Icons.male,size: 14.sp,),
                    SizedBox(width: 10.w),
                    Text(S.of(context).male,style: TextStyle(
                      fontSize: 14.sp
                    ),),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: "Female",
                child: Row(
                  children: [
                    Icon(Icons.female,size: 14.sp,),
                    SizedBox(width: 10.w),
                    Text(S.of(context).female,style: TextStyle(
                        fontSize: 14.sp
                    ),),
                  ],
                ),
              ),
            ],
            value: selectedGender,
            onChanged: (value) {
              setState(() {
                selectedGender = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).genderIsRequired;
              }
              return null;
            },
          ),
           SizedBox(height: 16.sp),
          CustomTextField(
            controller: email,
            hintText: S.of(context).email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return S.of(context).emailIsRequired;
              }
              return null;
            },
          ),
           SizedBox(height: 16.sp),
          CustomTextField(
            controller: password,
            hintText: S.of(context).password,
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
           SizedBox(height: 16.sp),
          CustomTextField(
            controller: confirmPassword,
            hintText: S.of(context).confirmPassword,
            isPassword: true,
            isPasswordVisible: isPasswordVisible,
            togglePasswordVisibility: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return S.of(context).confirmPasswordIsRequired;
              }
              if (value != password.text) {
                return S.of(context).PasswordDoesNotMatch;
              }
              return null;
            },
          ),
           SizedBox(height: 16.sp),
          Row(
            children: [
              Checkbox(
                value: isOption1Selected,
                onChanged: (value) {
                  setState(() {
                    isOption1Selected = value!;
                  });
                },
              ),
               Text(S.of(context).iAgreeToTermsAndConditions,style: TextStyle(
                   fontSize: 12.sp
               )),
            ],
          ),
          SizedBox(
            height: 12.sp,
          ),
          Button(
            name: Text(S.of(context).signUp,style: textButtonStyle,),
            onTap: () {
              if (formKey.currentState!.validate()) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                      (route) => false,
                );
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(S.of(context).alreadyHaveAnAccount,style: TextStyle(
                  fontSize: 12.sp
              )),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  S.of(context).login,
                  style: textButtonStyle.copyWith(
                    color: AppColor.main,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
