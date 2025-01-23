import 'package:flutter/material.dart';
import 'package:healthy_sync/Widgets/FormLogin.dart';
import 'package:healthy_sync/unts/AppColor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         // backgroundColor: AppColor.main,
      body: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            gradient: AppColor.primaryGradient,
          ),
          child: Column(
            spacing: 16,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Welcome To Healthy Sync",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "Login to your account",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              SizedBox(
                height:30,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24)),
                  ),
                  child:FormLogin(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
