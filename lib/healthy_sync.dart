import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:healthy_sync/core/Themes/light_theme.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/signup_cubit/signup_cubit.dart';
import 'package:healthy_sync/feature/profile/cubit/profile_cubit.dart';
import 'package:healthy_sync/feature/welcome/presentation/screens/splash/splash_screen.dart';

class HealthySync extends StatelessWidget {
  const HealthySync({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileCubit()..getProfileData()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SignUpCubit(),),
       
      
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
                // darkTheme: darkTheme,
                theme: themeLight,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                title: 'Healthy Sync',
                home: child);
          },
          child: SplashScreen()),
    );
  }
}
