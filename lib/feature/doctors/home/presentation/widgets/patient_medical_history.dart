import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';

class PatientMedicalHistory extends StatelessWidget {
  final Patient patient;

  const PatientMedicalHistory({
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
            Text(
              'السجل الطبي',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.mainBlue,
              ),
            ),
            SizedBox(height: 16.h),
            _buildMedicalHistoryItem(
              title: 'الأمراض المزمنة',
              content: patient.chronicDiseases?.join('، ') ?? '',
              icon: Icons.medical_services,
            ),
            SizedBox(height: 10.h),
            _buildMedicalHistoryItem(
              title: 'الحساسية',
              content: patient.allergies?.join('، ') ?? '',
              icon: Icons.warning,
            ),
            SizedBox(height: 10.h),
            _buildMedicalHistoryItem(
              title: 'الأدوية الحالية',
              content: patient.currentMedications?.join('، ') ?? '',
              icon: Icons.medication,
            ),
            SizedBox(height: 10.h),
            _buildMedicalHistoryItem(
              title: 'العمليات الجراحية',
              content: patient.surgicalHistory?.join('، ') ?? '',
              icon: Icons.medical_information,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalHistoryItem({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20.sp,
          color: AppColor.mainBlue,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.mainBlue,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                content.isEmpty ? 'لا يوجد' : content,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColor.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
