import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/widgets/ui_helpers.dart';
import 'package:healthy_sync/feature/patients/home/presentation/doctor_details/cubit/doctor_details_cubit.dart';
import 'package:healthy_sync/feature/patients/home/presentation/doctor_details/cubit/doctor_details_state.dart';

class DoctorDetails extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorDetails({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorDetailsCubit()..loadDoctorDetails(),
      child: BlocBuilder<DoctorDetailsCubit, DoctorDetailsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              toolbarHeight: 60.h,
              title: Text(
                'تفاصيل الطبيب',
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
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, DoctorDetailsState state) {
    if (state is DoctorDetailsLoading) {
      return showLoading();
    }

    if (state is DoctorDetailsError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.message),
            ElevatedButton(
              onPressed: () {
                context.read<DoctorDetailsCubit>().loadDoctorDetails();
              },
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      );
    }

    if (state is DoctorDetailsLoaded) {
      final doctor = state.doctor.first;
      return RefreshIndicator(
        onRefresh: () => context.read<DoctorDetailsCubit>().refresh(),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              _buildDoctorCard(
                context,
              ),
              SizedBox(height: 20.h),
              _buildAppointmentsCard(
                context,
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildDoctorCard(BuildContext context) {
    return Card(
      color: AppColor.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Image and Basic Info Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Image
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
                        imageUrl: doctor['image'] ?? '',
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
                // Doctor Name, Specialty and Experience
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor['name'] ?? 'غير معروف',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        doctor['specialization'] ?? 'تخصص عام',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColor.mainBlue,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Icon(Icons.work, color: Colors.grey, size: 18.sp),
                          SizedBox(width: 5.w),
                          Text(
                            doctor['experience'] ?? 'غير معروف',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 18.sp),
                          SizedBox(width: 5.w),
                          Text(
                            doctor['rating']?.toStringAsFixed(1) ?? '0.0',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            '(${doctor['reviews_count'] ?? 0})',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            // Doctor Description
            Text(
              doctor['description'] ?? 'لا يوجد وصف متاح',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentsCard(
    BuildContext context,
  ) {
    List<dynamic> appointments = doctor['appointments'] ?? [];

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
              'المواعيد المتاحة',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15.h),
            ...appointments.map((appointment) {
              return Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: appointment['available']
                          ? Colors.grey[300]!
                          : Colors.red[100]!,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                    color: appointment['available']
                        ? Colors.white
                        : Colors.grey[50],
                  ),
                  padding: EdgeInsets.all(15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appointment['time'],
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: appointment['available']
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                          Text(
                            appointment['date'],
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: appointment['available']
                                  ? Colors.grey[600]
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      appointment['available']
                          ? InkWell(
                              onTap: () {
                                _confirmAppointment(
                                  context,
                                  appointment['date'],
                                  appointment['time'],
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.mainBlue,
                                  borderRadius: BorderRadius.circular(8.r),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 0.4,
                                      blurRadius: 4.4,
                                      offset: Offset(0, 0.4),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 6.h,
                                ),
                                child: Text(
                                  'احجز الان',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: Colors.red,
                                ),
                              ),
                              child: Text(
                                'غير متاح',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _confirmAppointment(BuildContext context, String date, String time) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحجز'),
        content: Text('هل تريد حجز موعد في $date الساعة $time؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              showSuccessSnackBar('تم حجز الموعد بنجاح', context);
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }
}
