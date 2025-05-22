import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/feature/chat/presentation/screens/chat_bot_screen.dart';
import 'package:healthy_sync/feature/patients/home/presentation/home/cubit/home_cubit.dart';
import 'package:healthy_sync/feature/patients/medical_tests/presentation/medical_tests/screen/medical_tests_screen.dart';

import 'package:healthy_sync/feature/patients/home/presentation/home/screen/home_screen.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/feature/patients/treatment_schedule/presentation/screen/treatment_schedule_screen.dart';

import 'package:healthy_sync/feature/patients/profile/presentation/profile/screen/profile_screen.dart';

class PatientHomeNavScreen extends StatefulWidget {
  const PatientHomeNavScreen({super.key});

  @override
  PatientHomeNavScreenState createState() => PatientHomeNavScreenState();
}

class PatientHomeNavScreenState extends State<PatientHomeNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    BlocProvider(
      create: (context) => HomeCubit()..loadData(),
      child: const HomePatientScreen(),
    ),
    const TreatmentScheduleScreen(),
    const ChatScreen(),
    const MedicalTestsScreen(),
     const ProfilePatientScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColor.transparent,
        color: AppColor.mainBlue,
        buttonBackgroundColor: AppColor.mainBlue,
        animationDuration: const Duration(milliseconds: 300),
        height: ResponsiveHelper.isMobile(context) ? 60 : 90,
        index: _selectedIndex,
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.home, size: 25.sp, color: AppColor.white),
            // label: 'Home',
          ),
          CurvedNavigationBarItem(
            child:
                Icon(Icons.notifications, size: 25.sp, color: AppColor.white),
            //label: 'Notifications',
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset(
              AppAssets.chatSvg,
              height: 25.sp,
              width: 25.sp,
              colorFilter: ColorFilter.mode(AppColor.white, BlendMode.srcIn),
            ),
            // label: 'Chat',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.medical_services,
                size: 25.sp, color: AppColor.white),
            // label: 'Medical Tests',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person, size: 25.sp, color: AppColor.white),
          ),
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
