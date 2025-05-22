import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';

class PatientInfoCard extends StatelessWidget {
  final Patient patient;

  const PatientInfoCard({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundColor: AppColor.mainBlue,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(700.r),
                child: CachedNetworkImage(
                  imageUrl: patient.image ?? '',
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              patient.name ?? '',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.mainBlue,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              '${patient.age} سنة',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColor.grey,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone,
                  size: 20.sp,
                  color: AppColor.mainBlue,
                ),
                SizedBox(width: 5.w),
                Text(
                  patient.phone ?? '',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
