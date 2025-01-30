import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/generated/l10n.dart';
import 'package:healthy_sync/view/Screens/Welcome/WelcomeScreen.dart';
import 'package:healthy_sync/view_model/Themes/Themedata.dart';
import 'package:intl/intl.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
        builder: (_ , child) {
         return MaterialApp(
             locale: Locale('en'), // تحديد اللغة الافتراضية
             supportedLocales: S.delegate.supportedLocales,
             localizationsDelegates: [
               S.delegate,
               GlobalMaterialLocalizations.delegate,
               GlobalWidgetsLocalizations.delegate,
               GlobalCupertinoLocalizations.delegate,
             ],
              debugShowCheckedModeBanner: false,
              theme: themeLight,
              title: 'Healthy Sync',
              home: child
          );

        },
        child: WelcomeScreen()
    );
  }
}
///dart run intl_utils:generate