import 'package:flutter/material.dart';

import 'package:healthy_sync/Widgets/FormSiginUp.dart';

import '../unts/AppColor.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            gradient: AppColor.primaryGradient,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 90),
                const Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  "Join us now",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: FormSiginUp(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}