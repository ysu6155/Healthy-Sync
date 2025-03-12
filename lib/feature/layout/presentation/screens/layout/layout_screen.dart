import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/feature/medical_tests/presentation/screens/medical_tests_screen.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/chat_bot/chat_bot_screen.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/treatment_schedule/treatment_schedule_screen.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/home/home_screen.dart';
import 'package:healthy_sync/core/utils/app_assets.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/feature/profile/presentation/screens/profile_screen.dart';

class TapBarScreen extends StatefulWidget {
  const TapBarScreen({super.key});

  @override
  TapBarScreenState createState() => TapBarScreenState();
}

class TapBarScreenState extends State<TapBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    TreatmentScheduleScreen(),
    ChatBotScreen(),
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
        color: AppColor.main,
        buttonBackgroundColor: AppColor.secondary,
        animationDuration: Duration(milliseconds: 300),
        height: 60.sp,
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
              _selectedIndex == 2 ? AppColor.main : AppColor.secondary,
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
