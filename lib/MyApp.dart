import 'package:flutter/material.dart';
import 'package:healthy_sync/Screens/HomeScreen.dart';
import 'package:healthy_sync/Screens/WelcomeScreen.dart';
import 'package:healthy_sync/Screens/tapbarScreen.dart';
import 'package:healthy_sync/Themes/Themedata.dart';
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeLight,
      title: 'Healthy Sync',
      home: WelcomeScreen(),
      // home: TapBarScreen()


    );
  }
}
