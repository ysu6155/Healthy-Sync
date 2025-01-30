import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/generated/l10n.dart';
import 'package:healthy_sync/view/Screens/SpecializationsAll/specializationsScreen.dart';
import 'package:healthy_sync/view/Screens/home/Widgets/DoctorVisitCard.dart';
import 'package:healthy_sync/view/Screens/home/Widgets/specializations.dart';
import 'package:healthy_sync/view_model/utils/AppAssets.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';

import 'Widgets/doctors_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.sp),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage: Image.asset(
                    AppAssets.image1,
                    width: 16.w,
                    height: 16.sp,
                    fit: BoxFit.cover,
                  ).image,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${S.of(context).hello} 👋",
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Youssif Shaban",
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColor.secondary,
                  child: IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: AppColor.white,
                      size: 20.sp,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 16.sp),
          DoctorVisitCard(),
          SizedBox(height: 16.sp),
          Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.0.sp),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        S.of(context).specializations,
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SpecializationsAll();
                        }));
                      },
                      child: Text(
                        S.of(context).seeAll,
                        style: TextStyle(
                          color: AppColor.main,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.sp),
              SpecializationsSection(),
            ],
          ),
          SizedBox(height: 16.sp),
          DoctorsSection(),
        ],
      ),
    );
  }
}
