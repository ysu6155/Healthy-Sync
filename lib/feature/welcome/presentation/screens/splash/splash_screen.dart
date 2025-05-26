import 'package:flutter/material.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/feature/doctors/home_nav/presentation/screens/doctor_home_nav.dart';
import 'package:healthy_sync/feature/lab/home_nav/presentation/screens/lab_nav.dart';
import 'package:healthy_sync/feature/patients/home_nav/presentation/screens/patient_home_nav.dart';

import 'package:healthy_sync/feature/welcome/presentation/screens/intro/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 1));

    String? token = SharedHelper.get(SharedKeys.kToken);

    if (token != null) {
      final role = SharedHelper.get(SharedKeys.role);

      if (role == "patient") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const PatientHomeNavScreen()),
          (route) => false,
        );
      } else if (role == "doctor") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const DoctorHomeNavScreen()),
          (route) => false,
        );
      } else if (role == "admin") {
        context.pushReplacement(const LabHomeNavScreen());
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const IntroScreen()),
          (route) => false,
        );
      }
    } else {
      // ✅ لو مفيش توكن، روح على شاشة المقدمة
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const IntroScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset(AppAssets.logo)));
  }
}
