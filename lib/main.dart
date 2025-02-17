import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/healthy_sync.dart';
import 'package:healthy_sync/view_model/utils/app_assets.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: AppAssets.translationPath, // <-- change the path of the translation files
        fallbackLocale: Locale('en'),
     startLocale: Locale("en"),

     child:  HealthySync(),
      ),
  );
}

///flutter pub run easy_localization:generate -S assets/translations -O lib/view_model/translations -o locale_keys.g.dart -f keys
///flutter pub run flutter_native_splash:create