import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';

class PatientVisits extends StatelessWidget {
  final Patient patient;

  const PatientVisits({
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الزيارات السابقة',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.mainBlue,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to visits list
                  },
                  child: Text(
                    'عرض الكل',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColor.mainBlue,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // TODO: Add visits list
            Center(
              child: Text(
                'لا توجد زيارات سابقة',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColor.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
