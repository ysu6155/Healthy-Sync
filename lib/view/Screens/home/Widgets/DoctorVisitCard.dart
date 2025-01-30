import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/generated/l10n.dart';
import 'package:healthy_sync/view/Screens/DoctorVisit/DoctorVisitScreen.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';

class DoctorVisitCard extends StatelessWidget {
  const DoctorVisitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorVisitScreen(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.0.sp),
        margin: EdgeInsets.symmetric(horizontal: 16.sp),
        decoration: BoxDecoration(
          gradient: AppColor.primaryGradient,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: AppColor.white),
                SizedBox(width: 8.w),
                Text(
                  'Dr. Ahmed',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.white),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Cardiologist',
                  style: TextStyle(fontSize: 16.sp, color: AppColor.white),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: AppColor.white,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${S.of(context).time}: ١٢:٠٠ م',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColor.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: AppColor.white,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "Date: ١٢/١٢/٢٠٢١",
                      style: TextStyle(fontSize: 14.sp, color: AppColor.white),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.sp),
            Row(
              children: [
                Icon(Icons.location_on, color: AppColor.white),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Address: 1234 Main St, Cairo, Egypt',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontStyle: FontStyle.italic,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.sp),
            Row(
              children: [
                Icon(Icons.description, color: AppColor.white),
                SizedBox(width: 8.sp),
                Expanded(
                  child: Text(
                    'Details: The patient is experiencing chest pain.',
                    style: TextStyle(fontSize: 16.sp, color: AppColor.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.sp),
            Row(
              children: [
                Icon(Icons.health_and_safety, color: AppColor.green),
                SizedBox(width: 8.w),
                Text(
                  S.of(context).stable,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
