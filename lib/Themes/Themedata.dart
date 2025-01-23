import 'package:flutter/material.dart';

import '../unts/AppColor.dart';

ThemeData themeLight = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColor.lightGrey,
    hintStyle: TextStyle(color: Colors.grey),
    border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.border, width: 2.0),
        borderRadius: BorderRadius.circular(20)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.border, width: 2.0),
        borderRadius: BorderRadius.circular(16)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.border, width: 2.0),
      borderRadius: BorderRadius.circular(16),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.red, width: 2.0),
      borderRadius: BorderRadius.circular(16),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.accentRed, width: 2.0),
      borderRadius: BorderRadius.circular(16),
    ),
  ),
);
TextStyle textButtomStyle = TextStyle(
  color: AppColor.white,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);
