import 'package:flutter/material.dart';
import 'package:healthy_sync/Themes/Themedata.dart';
import 'package:healthy_sync/Widgets/Button.dart';
import 'package:healthy_sync/Widgets/CodeVerification.dart';
import 'package:healthy_sync/Widgets/Timer%D9%8BWidget.dart';
import 'package:healthy_sync/unts/AppColor.dart';

class VerificationScreen extends StatefulWidget {
  String Phone;
   VerificationScreen({super.key,required this.Phone});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController code1 = TextEditingController();
  TextEditingController code2 = TextEditingController();
  TextEditingController code3 = TextEditingController();
  TextEditingController code4 = TextEditingController();

  bool isCodeEmptyShown = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: AppColor.primaryGradientLight
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Image.asset(
                "assets/images/Verification.png", height: 130, width: 130,),
              const SizedBox(height: 16),
              Text(
                "Verification",
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Enter the code sent to your email or phone number",
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
             Text.rich(
                TextSpan(
                  text: "Code sent to ",
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: widget.Phone,
                      style: TextStyle(
                        color: AppColor.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                  ],

             ),
             ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
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
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Code",
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            TimerWidget(),

                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CodeVerification(controllerCode: code1,),
                            CodeVerification(controllerCode: code2, ),
                            CodeVerification(controllerCode: code3),
                            CodeVerification(controllerCode: code4,)
                          ],
                        ),
                        if ( isCodeEmptyShown)
                          Column(
                            children: [
                              const SizedBox(height: 30),
                              Text(
                                "Code is required",
                                style: TextStyle(
                                  color: AppColor.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        else
                          const SizedBox(height: 30),
                        const SizedBox(height: 30),
                        Button(
                          name: Text("Verify",style: textButtomStyle,),
                          onTap: () {
                            if (formKey.currentState!.validate())  {
                              print("Verify");
                            } else {setState(() {
                              isCodeEmptyShown = true; // قم بتحديث الحالة لعرض النص بعد الضغط
                            });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),


            ],
          ),
        )
    );
  }
}
