import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/feature/chat/presentation/screens/chat_bot_screen.dart';
import 'package:healthy_sync/feature/lab/home/presentation/home/cubit/home_cubit.dart';
import 'package:healthy_sync/feature/lab/home/presentation/home/screen/home_screen.dart';
import 'package:healthy_sync/feature/lab/pharmacy/presentation/pages/drug_info_screen.dart';

import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/feature/lab/profile/presentation/profile/screens/profile_screen.dart';
import 'package:healthy_sync/feature/lab/report/presentation/pages/report.dart';

class LabHomeNavScreen extends StatefulWidget {
  const LabHomeNavScreen({super.key});

  @override
  LabHomeNavScreenState createState() => LabHomeNavScreenState();
}

class LabHomeNavScreenState extends State<LabHomeNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    BlocProvider(
      create: (context) => HomeCubit(),
      child: const HomeLabScreen(),
    ),
    const DrugInfoScreen(),
    const ChatScreen(),
    Report(),
    const ProfileLabScreen(),
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
        height: ResponsiveHelper.isMobile(context) ? 60 : 90,
        index: _selectedIndex,
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.home, size: 25.sp, color: AppColor.white),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.info, size: 25.sp, color: AppColor.white),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset(
              AppAssets.chatSvg,
              height: 25.sp,
              width: 25.sp,
              colorFilter: ColorFilter.mode(AppColor.white, BlendMode.srcIn),
            ),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.analytics, size: 25.sp, color: AppColor.white),
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
