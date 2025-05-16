import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';

class CardPatient extends StatelessWidget {
  const CardPatient({
    super.key,
    required this.patient,
  });

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: AppColor.mainBlue,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80.r,
            height: 80.r,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: CachedNetworkImage(
                imageUrl: patient.image ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          16.W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient.name ?? '',
                  style: TextStyles.font20WhiteBold,
                ),
                Text(
                  "${patient.age} سنة",
                  style: TextStyles.font16WhiteW500,
                ),
                Text("ذكر", style: TextStyles.font16WhiteW500),
              ],
            ),
          ),
          16.W,
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: AppColor.transparent,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              color: AppColor.white,
            ),
          ),
        ],
      ),
    );
  }
}
