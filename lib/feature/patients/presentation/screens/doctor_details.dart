import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';

import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';

class DoctorDetails extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorDetails({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48.sp,
        title: Text(LocaleKeys.doctorDetails.tr(), style: textStyleTitle),
        iconTheme: IconThemeData(color: AppColor.white, size: 24.sp),
        backgroundColor: AppColor.main,
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
              height: 200.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Image.network(
                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                fit: BoxFit.cover,
              ),
            ),
          ),
          16.H,
          Text(
            "${LocaleKeys.name.tr()}:",
            style: textStyleTitle.copyWith(color: AppColor.black),
          ),
          8.H,
          Text(
            " ${doctor["name"]}",
            style: textStyleBody.copyWith(color: AppColor.black),
          ),
          8.H,
          Text(
            "${LocaleKeys.specialization.tr()}:",
            style: textStyleTitle.copyWith(color: AppColor.black),
          ),
          8.H,
          Text(
            "${doctor["specialty"]}",
            style: textStyleBody.copyWith(color: AppColor.black),
          ),
          8.H,
          Text(
            "${LocaleKeys.rating.tr()}:",
            style: textStyleTitle.copyWith(color: AppColor.black),
          ),
          8.H,
          Row(
            children: [
              Icon(Icons.star, color: AppColor.amber, size: 20.sp),
              4.W,
              Text(
                " ${doctor["rating"]}/5.0",
                style: textStyleBody.copyWith(color: AppColor.black),
              ),
            ],
          ),
          16.H,
          Text(
            "${LocaleKeys.AboutDoctor.tr()}:",
            style: textStyleTitle.copyWith(color: AppColor.black),
          ),
          8.H,
          Text(
            doctor["about"] ?? LocaleKeys.NoAdditionalInformationProvided.tr(),
            style: textStyleBody.copyWith(color: AppColor.black),
          ),
          16.H,
          CustomButton(
            name: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocaleKeys.callDoctor.tr(), style: textStyleTitle),
                8.W,
                Icon(Icons.call, color: AppColor.white, size: 20.sp),
              ],
            ),
            onTap: () {},
          ),
          8.H,
          CustomButton(
            name: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocaleKeys.chatWithDoctor.tr(), style: textStyleTitle),
                8.W,
                Icon(Icons.chat, color: AppColor.white, size: 20.sp),
              ],
            ),
            onTap: () {},
          ),
        ],
      ).paddingAll(16.sp),
    );
  }
}
