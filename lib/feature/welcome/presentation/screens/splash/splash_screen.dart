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
  String? token = SharedHelper.get(SharedKeys.kToken);
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    context.pushReplacement(const PatientHomeNavScreen());
    if (token != null) {
      // if (SharedHelper.get(SharedKeys.role) == "patient") {
      //   context.pushReplacement(const PatientHomeNavScreen());
      // } else if (SharedHelper.get(SharedKeys.role) == "doctor") {
      //   context.pushReplacement(const DoctorHomeNavScreen());
      // } else if (SharedHelper.get(SharedKeys.role) == "lab") {
      //   context.pushReplacement(const LabHomeNavScreen());
      // } else {
      //   context.pushReplacement(const IntroScreen());
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset(AppAssets.logo)));
  }
}
