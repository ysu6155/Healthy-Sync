import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_sync/Themes/Themedata.dart';
import 'package:healthy_sync/Widgets/Button.dart';
import 'package:healthy_sync/Widgets/CustomTextField.dart';
import 'package:healthy_sync/unts/AppColor.dart';

import 'Verificationscreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final email = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
            gradient: AppColor.primaryGradient,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/forgotpassword.png",
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 50),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          CustomTextField(
                              controller: email,
                              labelText: "Email or Phone",
                              labelStyle: TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Enter your email or phone number",
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email or phone is required";
                                }
                                return null;
                              }),
                          const SizedBox(height: 32),
                          Button(
                            name: Text("Send Code",style: textButtomStyle,),
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VerificationScreen(Phone: email.text,)));
                              }
                            },
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
