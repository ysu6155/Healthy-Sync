import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_sync/feature/chat/presentation/screens/chat_bot_screen.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/feature/pharmacy/presentation/pages/home_pharmacy_screen.dart';
import 'package:healthy_sync/feature/pharmacy/presentation/pages/medication_orders.dart';
import 'package:healthy_sync/feature/pharmacy/presentation/pages/medicine_lookup.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/screens/profile_screen.dart';

class PharmacyHomeNavScreen extends StatefulWidget {
  const PharmacyHomeNavScreen({super.key});

  @override
  PharmacyHomeNavScreenState createState() => PharmacyHomeNavScreenState();
}

class PharmacyHomeNavScreenState extends State<PharmacyHomeNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePharmacy(),
    MedicineLookup(),
    ChatScreen(),
    MedicationOrders(),
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
        buttonBackgroundColor: AppColor.mainBlue,
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
            AppAssets.homeIcon,
            colorFilter: ColorFilter.mode(
              _selectedIndex == 2 ? AppColor.mainPink : AppColor.mainBlue,
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
