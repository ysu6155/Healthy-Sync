import 'package:flutter/material.dart';
import 'package:healthy_sync/unts/AppColor.dart';

class Button extends StatelessWidget {
  Widget name;
  Gradient? backgroundColor;
  Color? textColor;
  void Function() onTap;
   Button ({super.key,required this.name, this.backgroundColor, this.textColor,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
         gradient:backgroundColor??AppColor.primaryGradient,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
            child: name
        ),
      ),
    );
  }
}
