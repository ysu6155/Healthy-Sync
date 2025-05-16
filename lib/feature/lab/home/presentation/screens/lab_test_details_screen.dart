import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';
import 'package:healthy_sync/feature/lab/home/data/lab_test_model.dart';

class LabTestDetailsScreen extends StatelessWidget {
  final LabTestPDF labTest;

  const LabTestDetailsScreen({super.key, required this.labTest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: Text(
          'تفاصيل التحليل',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPatientInfo(),
            SizedBox(height: 20.h),
            _buildTestDetails(),
            SizedBox(height: 20.h),
            _buildTestImage(),
            SizedBox(height: 20.h),
            _buildNotes(),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientInfo() {
    return Card(
      color: AppColor.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'معلومات المريض',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Icon(Icons.person, color: AppColor.mainBlue, size: 18.sp),
                SizedBox(width: 10.w),
                Text(
                  labTest.patient.name ?? '',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(Icons.phone, color: AppColor.mainBlue, size: 18.sp),
                SizedBox(width: 10.w),
                Text(
                  labTest.patient.phone ?? '',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestDetails() {
    return Card(
      color: AppColor.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'تفاصيل التحليل',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15.h),
            _buildDetailRow('نوع التحليل', labTest.testType),
            SizedBox(height: 10.h),
            _buildDetailRow('اسم التحليل', labTest.testName),
            SizedBox(height: 10.h),
            _buildDetailRow('التاريخ', _formatDate(labTest.date)),
          ],
        ),
      ),
    );
  }

  Widget _buildTestImage() {
    return Card(
      color: AppColor.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'صورة التحليل',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15.h),
            Container(
              width: double.infinity,
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 50.sp,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotes() {
    return Card(
      color: AppColor.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ملاحظات',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              labTest.notes,
              style: TextStyle(fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.mainBlue,
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
