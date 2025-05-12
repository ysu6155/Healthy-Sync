
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/Themes/light_theme.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/signup_cubit/signup_cubit.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/verification_cubit/cubit/verification_cubit.dart';
import 'package:healthy_sync/feature/chat/presentation/screens/chat_bot_screen.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/cubit/bmi/bmi_cubit.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/cubit/profile_cubit.dart';
import 'package:healthy_sync/feature/welcome/presentation/screens/splash/splash_screen.dart';

class HealthySync extends StatelessWidget {
  const HealthySync({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => VerificationCubit()),
        BlocProvider(create: (context) => BMICalculatorCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            theme: themeLight,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: 'Healthy Sync',
            home: child,
          );
        },
        child: ResponsiveHelper.buildResponsiveUI(
          mobile:  SplashScreen(),
          tablet: SplashScreen(),
          web: ChatScreen(),
          context: context,
        ),
      ),
    );
  }
}

