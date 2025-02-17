import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/view/Screens/patients/home/Widgets/doctor_visit_card.dart';
import 'package:healthy_sync/view/Screens/patients/home/Widgets/specializations.dart';
import 'package:healthy_sync/view/screens/patients/specializations_all/specializations_screen.dart';
import 'package:healthy_sync/view_model/translations/locale_keys.g.dart';
import 'package:healthy_sync/view_model/utils/app_assets.dart';
import 'package:healthy_sync/view_model/utils/app_color.dart';
import 'package:healthy_sync/view_model/utils/extensions.dart';

import 'Widgets/doctors_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: ListView(
        children: [
          Row(
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
             16.W,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${LocaleKeys.hello.tr()} 👋",
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
                child: Icon(
                    Icons.notifications,
                    color: AppColor.white,
                    size: 20.sp,
                  
                ),
              ).withTapEffect(onTap: () {
                //تغير اللغه موقتنا
                  print(context.locale.toString());
                  if (context.locale.toString() == 'ar') {
                    context.setLocale(Locale('en'));
                  } else {
                    context.setLocale(Locale('ar'));
                  }

               },)
            ],
          ).paddingAll(16.sp),
          16.H,
          DoctorVisitCard().paddingSymmetric(horizontal: 16.w),
           16.H,
          Row(
            children: [
              Expanded(
                child: Text(
                  LocaleKeys.specializations.tr(),
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
                  LocaleKeys.seeAll.tr(),
                  style: TextStyle(
                    color: AppColor.main,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16.0.sp),
          8.H,
          SpecializationsSection(),
          16.H,
          DoctorsSection(),
        ],
      ),
    );
  }
}
