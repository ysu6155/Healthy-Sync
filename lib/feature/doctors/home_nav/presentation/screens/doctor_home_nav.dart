import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/feature/chat/presentation/screens/chat_bot_screen.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/screens/appointments_screen.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/screens/booked_appointments_screen.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/screens/home_screen.dart';

import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/feature/doctors/profile/presentation/screens/profile_screen.dart';

import 'package:healthy_sync/feature/patients/profile/presentation/screens/profile_screen.dart';

class DoctorHomeNavScreen extends StatefulWidget {
  const DoctorHomeNavScreen({super.key});

  @override
  DoctorHomeNavScreenState createState() => DoctorHomeNavScreenState();
}

class DoctorHomeNavScreenState extends State<DoctorHomeNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeDoctorScreen(),
    AppointmentsScreen(),
    ChatScreen(),
    BookedAppointmentsScreen(),
    ProfileDoctorScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColor.transparent,
        color: AppColor.mainPink,
        buttonBackgroundColor: AppColor.mainPink,
        animationDuration: Duration(milliseconds: 300),
        height: ResponsiveHelper.isMobile(context) ? 60 : 75,
        index: _selectedIndex,
        items: [
          Icon(Icons.home, size: 25.sp, color: AppColor.white),
          Icon(Icons.notifications, size: 25.sp, color: AppColor.white),
          SvgPicture.asset(
            AppAssets.chatSvg,
            height: 25.sp,
            width: 25.sp,
            colorFilter: ColorFilter.mode(AppColor.white, BlendMode.srcIn),
          ),
          Icon(Icons.calendar_month, size: 25.sp, color: AppColor.white),
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
