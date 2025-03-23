import 'package:flutter/material.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColor.darkGrey,
  inputDecorationTheme: inputDecorationTheme(AppColor.darkGrey, AppColor.white),
);
