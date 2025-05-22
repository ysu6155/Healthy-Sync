import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';

class PatientPrescriptions extends StatelessWidget {
  final Patient patient;

  const PatientPrescriptions({
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
                  'الوصفات الطبية',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.mainBlue,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to prescriptions list
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
            // TODO: Add prescriptions list
            Center(
              child: Text(
                'لا توجد وصفات طبية',
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
