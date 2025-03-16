import 'package:flutter/material.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/utils/app_color.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColor.darkGrey,
  inputDecorationTheme: inputDecorationTheme(AppColor.darkGrey, AppColor.white),
);
