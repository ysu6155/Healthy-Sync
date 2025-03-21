import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/doctor_visit_screen.dart';

class DoctorVisitCard extends StatefulWidget {
  const DoctorVisitCard({super.key});

  @override
  State<DoctorVisitCard> createState() => _DoctorVisitCardState();
}

class _DoctorVisitCardState extends State<DoctorVisitCard> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: AppColor.main,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDoctorInfo(),
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
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DoctorVisitScreen()),
          ),
    );
  }

  Widget _buildDoctorInfo() {
    return Row(
      children: [
        Icon(Icons.person, color: AppColor.white),
        8.W,
        Text('Dr. John Doe', style: textStyleTitle),
        8.W,
        Text('Cardiologist', style: textStyleBody),
      ],
    );
  }

  Widget _buildTimeAndDate(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.schedule, color: AppColor.white),
            8.W,
            Text('${LocaleKeys.time.tr()}: ١٢/١٢/٢٠٢١', style: textStyleBody),
          ],
        ),
        Row(
          children: [
            Icon(Icons.calendar_today, color: AppColor.white),
            8.W,
            Text('Date: ١٢/١٢/٢٠٢١', style: textStyleBody),
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
        Text('Address: 1234 Main St, Cairo', style: textStyleBody),
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
            style: textStyleBody,
          ),
        ),
      ],
    );
  }

  Widget _buildHealthStatus(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.favorite, color: AppColor.white),
        8.W,
        Text('Stable Condition', style: textStyleBody),
      ],
    );
  }
}
