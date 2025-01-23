import 'package:flutter/material.dart';

import '../unts/AppColor.dart';

class CodeVerification extends StatelessWidget {
  TextEditingController controllerCode;

   CodeVerification({super.key,required this.controllerCode });

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextFormField(
          controller: controllerCode,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),

          validator: (value) {
            if (value!.isEmpty) {
              return "";
            }
          },
        ),
      ),
    );
  }
}
