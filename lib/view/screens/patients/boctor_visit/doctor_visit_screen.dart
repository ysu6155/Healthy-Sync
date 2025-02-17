import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/view_model/translations/locale_keys.g.dart';
import 'package:healthy_sync/view_model/utils/app_assets.dart';
import 'package:healthy_sync/view_model/utils/app_color.dart';
import 'package:healthy_sync/view_model/utils/extensions.dart';

class DoctorVisitScreen extends StatelessWidget {
  const DoctorVisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          LocaleKeys.city.tr(),
          style: TextStyle(
            color: AppColor.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: AppColor.white),
        backgroundColor: AppColor.main,
        elevation: 4, // ظل خفيف
      ),
      body: ListView(
        children: [
          _buildCard(
            title: "LocaleKeys.doctorDetails",
            child: _buildDoctorInfo(),
          ),
          _buildCard(
            title: "LocaleKeys.appointmentDetails",
            child: _buildTimeAndDate(context),
          ),
          _buildCard(
            title: "LocaleKeys.location",
            child: _buildLocation(),
          ),
          _buildCard(
            title: "LocaleKeys.medicalDetails",
            child: _buildDetails(),
          ),
          _buildCard(
            title: "LocaleKeys.healthStatus",
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
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.main,
              ),
            ),
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
          backgroundImage: AssetImage(AppAssets.image1),
        ),
      12.W,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dr. Ahmed',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              'Cardiologist',
              style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade700),
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
        _buildInfoRow(Icons.calendar_today, 'Date: ١٢/١٢/٢٠٢١'),
      ],
    );
  }

  Widget _buildLocation() {
    return _buildInfoRow(
      Icons.location_on,
      'Address: 1234 Main St, Cairo, Egypt',
    );
  }

  Widget _buildDetails() {
    return Column(
      children: [
        _buildInfoRow(Icons.description, 'Diagnosis: Chest Pain & High BP'),
        8.H,
        _buildInfoRow(Icons.medical_services, 'Prescription: Aspirin 100mg Daily'),
        8.H,
        _buildInfoRow(Icons.analytics, 'Required Tests: ECG, Blood Test'),
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

  Widget _buildInfoRow(IconData icon, String text, {Color? iconColor, Color? textColor}) {
    return Row(
      children: [
        Icon(icon, color: iconColor ?? AppColor.main, size: 22.sp),
      8.W,
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              color: textColor ?? Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
