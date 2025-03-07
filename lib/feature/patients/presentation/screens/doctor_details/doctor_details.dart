import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/Themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';

class DoctorDetails extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorDetails({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48.sp,
        title: Text(doctor["name"], style: textButtonStyle),
        iconTheme: IconThemeData(color: AppColor.white, size: 16.sp),
        backgroundColor: AppColor.main,
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
              width: double.infinity.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Image.asset(
                doctor["image"],
                fit: BoxFit.cover,
              ),
            ),
          ),
          16.H,
          Text(
            "${LocaleKeys.name.tr()}: ${doctor["name"]}",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          8.H,
          Text(
            "${LocaleKeys.specialization.tr()}: ${doctor["specialty"]}",
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey,
            ),
          ),
          8.H,
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 16.sp,
              ),
              4.W,
              Text(
                "Rating: ${doctor["rating"]}/5.0",
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
          16.H,
          Text(
            "${LocaleKeys.AboutDoctor.tr()}:",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          8.H,
          Text(
            doctor["about"] ?? LocaleKeys.NoAdditionalInformationProvided.tr(),
            style: TextStyle(fontSize: 16.sp),
          ),
          16.H,
          CustomButton(
            name: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.callDoctor.tr(),
                  style: textButtonStyle,
                ),
                8.W,
                Icon(
                  Icons.call,
                  color: AppColor.white,
                  size: 16.sp,
                ),
              ],
            ),
            onTap: () {},
          ),
          8.H,
          CustomButton(
            name: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.chatWithDoctor.tr(),
                  style: textButtonStyle,
                ),
                8.W,
                Icon(
                  Icons.chat,
                  color: AppColor.white,
                  size: 16.sp,
                ),
              ],
            ),
            onTap: () {},
          )
        ],
      ).paddingAll(16.sp),
    );
  }
}
