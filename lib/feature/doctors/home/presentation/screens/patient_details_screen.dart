import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/screens/prescription_screen.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/screens/prescriptions_list_screen.dart';

class PatientDetailsScreen extends StatelessWidget {
  final Patient patient;

  const PatientDetailsScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: Text(
          'تفاصيل المريض',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[200],
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            _buildPatientCard(context),
            SizedBox(height: 20.h),
            _buildMedicalHistoryCard(context),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      bottomNavigationBar: _buildPrescriptionButton(context),
    );
  }

  Widget _buildPatientCard(BuildContext context) {
    return Card(
      color: AppColor.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 0.4,
                        blurRadius: 4.4,
                        offset: const Offset(0, 0.4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50.r,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(700.r),
                      child: CachedNetworkImage(
                        imageUrl: patient.image ?? '',
                        width: 100.w,
                        height: 100.h,
                        fit: BoxFit.cover,
                        placeholder:
                            (context, url) => Container(
                              color: Colors.grey[200],
                              child: Icon(Icons.person, size: 50.sp),
                            ),
                        errorWidget:
                            (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient.name ?? '',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        '${patient.age} سنة',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColor.mainBlue,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.grey, size: 18.sp),
                          SizedBox(width: 5.w),
                          Text(
                            patient.phone ?? '',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                            size: 18.sp,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            'آخر زيارة: 15/3/2024',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalHistoryCard(BuildContext context) {
    return Card(
      color: AppColor.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'السجل الطبي',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                CustomButton(
                  width: 100.w,
                  height: 35.h,
                  name: 'عرض الروشته',
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                PrescriptionsListScreen(patient: patient),
                      ),
                    );
                  },
                  backgroundColor: AppColor.mainBlue,
                ),
              ],
            ),
            SizedBox(height: 15.h),
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

  Widget _buildPrescriptionButton(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: CustomButton(
          width: double.infinity,
          height: 50.h,
          name: 'تسجيل روشته',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PrescriptionScreen(patient: patient),
              ),
            );
          },
          backgroundColor: AppColor.mainBlue,
        ),
      ),
    );
  }

  Widget _buildMedicalHistoryItem({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColor.mainBlue, size: 24.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  content,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
