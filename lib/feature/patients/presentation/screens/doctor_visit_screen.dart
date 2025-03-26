import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';

class DoctorVisitScreen extends StatelessWidget {
  const DoctorVisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text(LocaleKeys.visitDetails.tr(), style: textStyleTitle),
        iconTheme: IconThemeData(color: AppColor.white, size: 24.sp),
        backgroundColor: AppColor.mainPink,
        elevation: 4,
      ),
      body: ListView(
        children: [
          _buildCard(
            title: LocaleKeys.doctorDetails.tr(),
            child: _buildDoctorInfo(),
          ),
          _buildCard(
            title: LocaleKeys.appointmentDetails.tr(),
            child: _buildTimeAndDate(context),
          ),
          _buildCard(title: LocaleKeys.address.tr(), child: _buildLocation()),
          _buildCard(
            title: LocaleKeys.medicineDetails.tr(),
            child: _buildDetails(),
          ),
          _buildCard(
            title: LocaleKeys.status.tr(),
            child: _buildHealthStatus(context),
          ),
        ],
      ).paddingAll(16.sp),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16.sp),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: textStyleTitle.copyWith(color: AppColor.black)),
            8.H,
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundImage:
              Image.network(
                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                fit: BoxFit.cover,
              ).image,
        ),
        12.W,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dr. Ahmed',
              style: textStyleTitle.copyWith(color: AppColor.black),
            ),
            Text(
              'Cardiologist',
              style: textStyleBody.copyWith(color: AppColor.black),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeAndDate(BuildContext context) {
    return Column(
      children: [
        _buildInfoRow(Icons.access_time, '${LocaleKeys.time.tr()}: ١٢:٠٠ م'),
        8.H,
        _buildInfoRow(
          Icons.calendar_today,
          '${LocaleKeys.date.tr()}: ١٢/١٢/٢٠٢١',
        ),
      ],
    );
  }

  Widget _buildLocation() {
    return _buildInfoRow(Icons.location_on, ' 1234 Main St, Cairo, Egypt');
  }

  Widget _buildDetails() {
    return Column(
      children: [
        _buildInfoRow(
          Icons.description,
          '${LocaleKeys.symptoms.tr()}: Chest Pain & High BP',
        ),
        8.H,
        _buildInfoRow(
          Icons.medical_services,
          '${LocaleKeys.medicine.tr()}: Aspirin 100mg Daily',
        ),
        8.H,
        _buildInfoRow(
          Icons.analytics,
          '${LocaleKeys.tests.tr()}: ECG, Blood Test',
        ),
      ],
    );
  }

  Widget _buildHealthStatus(BuildContext context) {
    return _buildInfoRow(
      Icons.health_and_safety,
      LocaleKeys.stable.tr(),
      iconColor: AppColor.green,
      textColor: AppColor.green,
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String text, {
    Color? iconColor,
    Color? textColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor ?? AppColor.mainPink, size: 22.sp),
        8.W,
        Expanded(
          child: Text(
            text,
            style: textStyleBody.copyWith(color: textColor ?? AppColor.black),
          ),
        ),
      ],
    );
  }
}
