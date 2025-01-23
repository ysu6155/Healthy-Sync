import 'package:flutter/material.dart';
import 'package:healthy_sync/Screens/HomeScreen.dart';
import 'package:healthy_sync/Widgets/Button.dart';
import 'package:healthy_sync/unts/AppColor.dart';

import '../Screens/LoginScreen.dart';
import '../Themes/Themedata.dart';
import 'CityDropdown.dart';
import 'CustomTextField.dart';

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
            hintText: "Name",
            validator: (value) {
              if (value!.isEmpty) {
                return "Name is required";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: phone,
            hintText: "Phone",
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return "Phone is required";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CityForm(),
          const SizedBox(height: 16),
          CustomTextField(
            controller: age,
            hintText: "Age",
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return "Age is required";
              }
              if (int.tryParse(value) == null) {
                return "Please enter a valid number";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            hint: Text("Gender"),
            items: const [
              DropdownMenuItem(
                value: "Male",
                child: Row(
                  children: [
                    Icon(Icons.male),
                    SizedBox(width: 10),
                    Text("Male"),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: "Female",
                child: Row(
                  children: [
                    Icon(Icons.female),
                    SizedBox(width: 10),
                    Text("Female"),
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
                return "Gender is required";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: email,
            hintText: "Email",
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return "Email is required";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: password,
            hintText: "Password",
            isPassword: true,
            isPasswordVisible: isPasswordVisible,
            togglePasswordVisibility: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Password is required";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: confirmPassword,
            hintText: "Confirm Password",
            isPassword: true,
            isPasswordVisible: isPasswordVisible,
            togglePasswordVisibility: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Confirm Password is required";
              }
              if (value != password.text) {
                return "Password does not match";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
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
              const Text("I agree to the terms and conditions"),
            ],
          ),
          Button(
            name: Text("Sign Up",style: textButtomStyle,),
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
              const Text("Already have an account?"),
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
                  "Login",
                  style: textButtomStyle.copyWith(
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
