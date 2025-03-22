import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/specializations_screen.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/feature/patients/presentation/widgets/doctor_visit_card.dart';
import 'package:healthy_sync/feature/patients/presentation/widgets/doctors_section.dart';
import 'package:healthy_sync/feature/patients/presentation/widgets/specializations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage:
                    Image.network(
                      "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",

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
                      style: textStyleBody.copyWith(color: AppColor.black),
                    ),
                    Text(
                      "Youssif Shaban",
                      style: textStyleBody.copyWith(color: AppColor.black),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColor.main,
                child: Icon(
                  Icons.notifications,
                  color: AppColor.white,
                  size: 20.sp,
                ),
              ).withTapEffect(
                onTap: () {
                  log(context.locale.toString());
                  if (context.locale.toString() == 'ar') {
                    context.setLocale(Locale('en'));
                  } else {
                    context.setLocale(Locale('ar'));
                  }
                },
              ),
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
                  style: textStyleTitle.copyWith(color: AppColor.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SpecializationsAll();
                      },
                    ),
                  );
                },
                child: Text(
                  LocaleKeys.seeAll.tr(),
                  style: textStyleBody.copyWith(color: AppColor.main),
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
