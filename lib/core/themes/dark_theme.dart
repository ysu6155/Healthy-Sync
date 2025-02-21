import 'package:flutter/material.dart';
import 'package:healthy_sync/view_model/themes/light_theme.dart';
import 'package:healthy_sync/view_model/utils/app_color.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColor.darkGrey,
  inputDecorationTheme: inputDecorationTheme(
    AppColor.darkGrey,
    AppColor.white,
  ),
);
