import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/feature/patients/home/presentation/screens/specializations_screen.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/feature/patients/home/presentation/widgets/doctor_visit_card.dart';
import 'package:healthy_sync/feature/patients/home/presentation/widgets/doctors_section.dart';
import 'package:healthy_sync/feature/patients/home/presentation/widgets/specializations.dart';

class HomePatientScreen extends StatefulWidget {
  const HomePatientScreen({super.key});

  @override
  State<HomePatientScreen> createState() => _HomePatientScreenState();
}

class _HomePatientScreenState extends State<HomePatientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage: Image.network(
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
                      style: TextStyles.font16DarkBlueW500.copyWith(
                        color: AppColor.black,
                      ),
                    ),
                    Text(
                      "Youssif Shaban",
                      style: TextStyles.font16DarkBlueW500.copyWith(
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColor.mainBlue,
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
          const DoctorVisitCard().paddingSymmetric(horizontal: 16.w),
          16.H,
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: AppColor.mainBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.medical_services_outlined,
                  color: AppColor.mainBlue,
                  size: 20.sp,
                ),
              ),
              12.W,
              Expanded(
                child: Text(
                  LocaleKeys.specializations.tr(),
                  style: TextStyles.font20WhiteBold.copyWith(
                    color: AppColor.mainBlueDark,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SpecializationsAll();
                      },
                    ),
                  );
                },
                child: Text(
                  LocaleKeys.seeAll.tr(),
                  style: TextStyles.font16DarkBlueW500,
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16.0.sp),
          8.H,
          const SpecializationsSection(),
          16.H,
          const DoctorsSection(),
        ],
      ),
    );
  }
}
