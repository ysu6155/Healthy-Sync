import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:flutter/services.dart';

import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/health_sync.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // await Firebase.initializeApp();
  await SharedHelper.init();
  // SharedHelper.clear();
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: AppAssets
          .translationPath, // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      startLocale: Locale("ar"),

      child: const HealthSync(),
    ),
  );
}

///flutter pub run easy_localization:generate -S assets/translations -O lib/core/translations -o locale_keys.g.dart -f keys
///flutter pub run flutter_native_splash:create
