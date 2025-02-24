import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/boctor_visit/doctor_visit_screen.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_color.dart';

class DoctorVisitCard extends StatelessWidget {
  const DoctorVisitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        gradient: AppColor.primaryGradient,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDoctorInfo(),
          Divider(),
          8.H,
          _buildTimeAndDate(context),
          8.H,
          _buildLocation(),
          8.H,
          _buildDetails(),
          8.H,
          _buildHealthStatus(context),
        ],
      ),
    ).withTapEffect(
      onTap: () {
        context.push(DoctorVisitScreen());
      },
      splashColor: AppColor.main,
      highlightColor: AppColor.secondary,
    );
  }

  Widget _buildDoctorInfo() {
    return Row(
      children: [
        Icon(Icons.person, color: AppColor.white),
        8.W,
        Text(
          'Dr. Ahmed',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.white,
          ),
        ),
        8.W,
        Text(
          'Cardiologist',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColor.white,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeAndDate(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.access_time, color: AppColor.white),
            4.W,
            Text(
              '${LocaleKeys.time.tr()}: ١٢:٠٠ م',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColor.white,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.calendar_today, color: AppColor.white),
            4.W,
            Text(
              'Date: ١٢/١٢/٢٠٢١',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        Icon(Icons.location_on, color: AppColor.white),
        8.W,
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
    );
  }

  Widget _buildDetails() {
    return Row(
      children: [
        Icon(Icons.description, color: AppColor.white),
        8.W,
        Expanded(
          child: Text(
            'Details: The patient is experiencing chest pain.',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColor.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHealthStatus(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.health_and_safety, color: AppColor.green),
        8.W,
        Text(
          LocaleKeys.stable.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.green,
          ),
        ),
      ],
    );
  }
}
