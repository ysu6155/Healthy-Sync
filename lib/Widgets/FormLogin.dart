import 'package:flutter/material.dart';
import 'package:healthy_sync/Screens/ForgotPasswordScreen.dart';
import 'package:healthy_sync/Screens/HomeScreen.dart';
import 'package:healthy_sync/Screens/SignUpScraeen.dart';
import 'package:healthy_sync/Screens/tapbarScreen.dart';
import 'package:healthy_sync/Themes/Themedata.dart';
import 'package:healthy_sync/Widgets/Button.dart';
import 'package:healthy_sync/Widgets/CustomTextField.dart';
import 'package:healthy_sync/unts/AppColor.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  bool isPasswordVisible = false;
  bool isOption1Selected = false;
  @override
  Widget build(BuildContext context) {
    return Form (
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
            spacing: 16,
            children: [
              SizedBox(
                height: 16,
              ),
              CustomTextField(
                controller: email,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "Email or phone Number",
                keyboardType: TextInputType.emailAddress,
                labelText: "Email/Phone",
                labelStyle: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),

                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              CustomTextField(
                controller: password,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                keyboardType: TextInputType.text,
                labelText: "Password",
                labelStyle: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),

                hintText: "*"*8,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isOption1Selected,
                        onChanged: (value) {
                          setState(() {
                            isOption1Selected = value!;
                          }
                          );
                        },
                      ),
                      Text("Remember me"),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: AppColor.main,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Button(
                name: Text("Login",style: textButtomStyle,),
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TapBarScreen(),
                      ),
                          (route) => false,
                    );
                  }
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: AppColor.main,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ]),
      ),

    );
  }
}
