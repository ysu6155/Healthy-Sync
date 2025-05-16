import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/screens/patient_details_screen.dart';
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/widgets/card_patient.dart';

class HomeDoctorScreen extends StatefulWidget {
  const HomeDoctorScreen({super.key});

  @override
  State<HomeDoctorScreen> createState() => _HomeDoctorScreenState();
}

class _HomeDoctorScreenState extends State<HomeDoctorScreen> {
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
                  "https://b.top4top.io/p_3401vpliv1.jpg",
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
                      "${LocaleKeys.doctor.tr()} / Youssif Shaban",
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
          ),
          16.H,
          Text(
            LocaleKeys.findPatient.tr(),
            style: TextStyles.font20WhiteBold.copyWith(color: AppColor.black),
          ),
          16.H,
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.r),
              boxShadow: [
                BoxShadow(
                  color: AppColor.grey.withValues(alpha: 0.3),
                  spreadRadius: 0.4,
                  blurRadius: 4.4,
                  offset: const Offset(0, 0.4),
                ),
              ],
            ),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (value) {
                log(value);
              },
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.sp,
                  vertical: 18.h,
                ),
                filled: true,
                fillColor: AppColor.white,
                hintStyle: TextStyles.font12GreyW400,
                border: borderStyle(AppColor.border, 50.r),
                focusedBorder: borderStyle(AppColor.border, 50.r),
                enabledBorder: borderStyle(AppColor.transparent, 50.r),
                errorBorder: borderStyle(AppColor.red, 50.r),
                focusedErrorBorder: borderStyle(AppColor.red, 50.r),
                labelStyle: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
                hintText: "البحث عن مريض",
                prefixIcon: Icon(
                  Icons.search,
                  size: 25.sp,
                  color: AppColor.black,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    log("qr code");
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(title: Text("QR Code")),
                    );
                  },
                  child: Icon(
                    Icons.qr_code,
                    size: 20.sp,
                    color: AppColor.black,
                  ),
                ),
                errorStyle: TextStyles.font12BlueW400.copyWith(
                  color: AppColor.red,
                ),
              ),
              style: TextStyles.font12BlueW400.copyWith(
                fontSize: ResponsiveHelper.isMobile(context) ? 16.sp : 24.sp,
                color: AppColor.black,
              ),
            ),
          ),
          16.H,
          Text(
            LocaleKeys.recentPatients.tr(),
            style: TextStyles.font20WhiteBold.copyWith(color: AppColor.black),
          ),
          16.H,
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio:
                  ResponsiveHelper.isMobile(context) ? 2.6.sp : 1.4.sp,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 16.w,
            ),
            itemCount: patients.length,
            itemBuilder: (context, index) {
              final patient = patients[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PatientDetailsScreen(patient: patient),
                    ),
                  );
                },
                child: CardPatient(patient: patient),
              );
            },
          ),
        ],
      ).paddingAll(16.sp),
    );
  }
}
