import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/prescriptions_list/cubit/prescriptions_list_cubit.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/prescriptions_list/screen/prescriptions_list_screen.dart';
import 'package:healthy_sync/feature/lab/xray/presentation/screens/add_xray_screen.dart';
import 'package:healthy_sync/feature/lab/home/presentation/screens/new_lab_test_screen.dart';

class LabPatientDetailsScreen extends StatelessWidget {
  final Patient patient;

  const LabPatientDetailsScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[200],
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
            _buildPatientInfo(),
            SizedBox(height: 20.h),
            _buildQuickActions(context),
            SizedBox(height: 20.h),
            _buildRecentTests(),
            SizedBox(height: 20.h),
            _buildRecentXrays(),
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
                        placeholder: (context, url) => Container(
                          color: Colors.grey[200],
                          child: Icon(Icons.person, size: 50.sp),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
                          Icon(Icons.phone,
                              color: AppColor.mainBlue, size: 18.sp),
                          SizedBox(width: 5.w),
                          Text(
                            patient.phone ?? '',
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

  Widget _buildQuickActions(BuildContext context) {
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
              'إجراءات سريعة',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    name: 'إضافة أشعة',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddXrayScreen(
                            patient: patient,
                          ),
                        ),
                      );
                    },
                    backgroundColor: AppColor.mainBlue,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomButton(
                    name: 'إضافة تحليل',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewLabTestScreen(
                            patient: patient,
                          ),
                        ),
                      );
                    },
                    backgroundColor: AppColor.mainPink,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            CustomButton(
              name: 'الروشتات',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => PrescriptionsListCubit(),
                      child: PrescriptionsListScreen(patient: patient),
                    ),
                  ),
                );
              },
              backgroundColor: AppColor.mainBlueDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTests() {
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
              'التحاليل الأخيرة',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15.h),
            _buildTestItem(
              title: 'تحليل دم شامل',
              date: '15/3/2024',
              status: 'طبيعي',
              color: Colors.green,
            ),
            SizedBox(height: 10.h),
            _buildTestItem(
              title: 'تحليل سكر',
              date: '10/3/2024',
              status: 'مرتفع',
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentXrays() {
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
              'الأشعة الأخيرة',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15.h),
            _buildXrayItem(
              title: 'أشعة سينية - الصدر',
              date: '12/3/2024',
              status: 'طبيعي',
              color: Colors.green,
            ),
            SizedBox(height: 10.h),
            _buildXrayItem(
              title: 'أشعة مقطعية - البطن',
              date: '5/3/2024',
              status: 'يحتاج متابعة',
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestItem({
    required String title,
    required String date,
    required String status,
    required Color color,
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
          Icon(Icons.medical_services, color: AppColor.mainBlue, size: 24.sp),
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
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: color,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXrayItem({
    required String title,
    required String date,
    required String status,
    required Color color,
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
          Icon(Icons.medical_information,
              color: AppColor.mainBlue, size: 24.sp),
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
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: color,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
