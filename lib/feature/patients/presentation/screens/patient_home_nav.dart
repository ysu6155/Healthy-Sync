import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/feature/chat/presentation/screens/chat_bot_screen.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/medical_tests/medical_tests_screen.dart';

import 'package:healthy_sync/feature/patients/presentation/screens/treatment_schedule_screen.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/home_screen.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/themes/app_color.dart';

import 'package:healthy_sync/feature/profile/presentation/screens/profile_screen.dart';

class PatientHomeNavScreen extends StatefulWidget {
  const PatientHomeNavScreen({super.key});

  @override
  PatientHomeNavScreenState createState() => PatientHomeNavScreenState();
}

class PatientHomeNavScreenState extends State<PatientHomeNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    TreatmentScheduleScreen(),
    ChatScreen(),
    MedicalTestsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColor.transparent,
        color: AppColor.mainPink,
        buttonBackgroundColor: AppColor.secondary,
        animationDuration: Duration(milliseconds: 300),
        height: ResponsiveHelper.isMobile(context) ? 60 : 75,
        index: _selectedIndex,
        items: [
          SvgPicture.asset(
            AppAssets.homeIcon,
            colorFilter: ColorFilter.mode(AppColor.white, BlendMode.srcIn),
            height: 25.sp,
          ),
          Icon(Icons.notifications, size: 25.sp, color: AppColor.white),
          SvgPicture.asset(
            AppAssets.chatBot,
            colorFilter: ColorFilter.mode(
              _selectedIndex == 2 ? AppColor.mainPink : AppColor.secondary,
              BlendMode.srcIn,
            ),
            height: 32.sp,
          ),
          Icon(Icons.medical_services, size: 25.sp, color: AppColor.white),
          Icon(Icons.person, size: 25.sp, color: AppColor.white),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
