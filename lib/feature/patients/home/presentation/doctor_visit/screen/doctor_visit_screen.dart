import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/widgets/ui_helpers.dart';
import 'package:healthy_sync/feature/patients/home/data/models/doctor_visit.dart';
import 'package:healthy_sync/feature/patients/home/data/repositories/doctor_visit_repository.dart';
import 'package:healthy_sync/feature/patients/home/presentation/doctor_visit/cubit/doctor_visit_cubit.dart';
import 'package:healthy_sync/feature/patients/home/presentation/doctor_visit/cubit/doctor_visit_state.dart';

class DoctorVisitScreen extends StatelessWidget {
  final String visitId;

  const DoctorVisitScreen({
    super.key,
    required this.visitId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorVisitCubit(
        repository: DoctorVisitRepositoryImpl(),
      )..getVisitDetails(visitId),
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          toolbarHeight: 56.sp,
          title: Text(
            LocaleKeys.visitDetails.tr(),
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          iconTheme: IconThemeData(color: AppColor.white, size: 22.sp),
          backgroundColor: AppColor.mainBlue,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  AppColor.mainBlue,
                  AppColor.mainBlue.withOpacity(0.85),
                ],
              ),
            ),
          ),
        ),
        body: BlocBuilder<DoctorVisitCubit, DoctorVisitState>(
          builder: (context, state) {
            if (state is DoctorVisitLoading) {
              return showLoading();
            }

            if (state is DoctorVisitError) {
              return showError(
                message: state.message,
                onRetry: () {
                  context.read<DoctorVisitCubit>().getVisitDetails(visitId);
                },
              );
            }

            if (state is DoctorVisitLoaded) {
              return _buildContent(state.visit);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(DoctorVisit visit) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // معلومات الطبيب
          Container(
            margin: EdgeInsets.fromLTRB(12.sp, 8.sp, 12.sp, 4.sp),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  AppColor.mainBlue,
                  AppColor.mainBlue.withOpacity(0.85),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColor.mainBlue.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // عناصر زخرفية
                Positioned(
                  right: -15.w,
                  top: -15.h,
                  child: Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),
                ),
                Positioned(
                  left: -10.w,
                  bottom: -10.h,
                  child: Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),
                ),
                // محتوى معلومات الطبيب
                Padding(
                  padding: EdgeInsets.all(14.sp),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // صورة الطبيب
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 32.r,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(visit.imageUrl),
                              onBackgroundImageError: (_, __) {},
                              child: Icon(
                                Icons.person_outline,
                                size: 32.sp,
                                color: AppColor.mainBlue,
                              ),
                            ),
                          ),
                          10.W,
                          // معلومات الطبيب
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  visit.doctorName,
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    height: 1.2,
                                  ),
                                ),
                                6.H,
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.sp,
                                    vertical: 4.sp,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Text(
                                    visit.specialization,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                10.H,
                                // معلومات إضافية
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildDoctorInfoItem(
                                        Icons.star,
                                        visit.rating.toString(),
                                        "التقييم",
                                      ),
                                    ),
                                    8.W,
                                    Expanded(
                                      child: _buildDoctorInfoItem(
                                        Icons.work_outline,
                                        "${visit.experienceYears}+",
                                        "سنوات الخبرة",
                                      ),
                                    ),
                                  ],
                                ),
                                10.H,
                                // رقم الهاتف
                                Container(
                                  width: 1.sw,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.sp,
                                    vertical: 6.sp,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.15),
                                      width: 0.8.w,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5.sp),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.15),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.phone_outlined,
                                          color: Colors.white,
                                          size: 14.sp,
                                        ),
                                      ),
                                      6.W,
                                      Text(
                                        visit.phoneNumber,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // باقي المحتوى
          Padding(
            padding: EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 12.sp),
            child: Column(
              children: [
                8.H,
                _buildVisitInfoCard(visit),
                10.H,
                _buildDiagnosisCard(visit),
                10.H,
                _buildTreatmentCard(visit),
                10.H,
                _buildRecommendationsCard(visit),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitInfoCard(DoctorVisit visit) {
    return _buildCard(
      title: LocaleKeys.visitDetails.tr(),
      icon: Icons.calendar_today_outlined,
      child: Column(
        children: [
          _buildInfoRow(
            Icons.access_time,
            "${LocaleKeys.time.tr()}: ${visit.time}",
          ),
          12.H,
          _buildInfoRow(
            Icons.calendar_today,
            "${LocaleKeys.date.tr()}: ${visit.date}",
          ),
          12.H,
          _buildInfoRow(
            Icons.health_and_safety,
            "${LocaleKeys.status.tr()}: ${visit.status}",
            iconColor: AppColor.green,
            textColor: AppColor.green,
          ),
        ],
      ),
    );
  }

  Widget _buildDiagnosisCard(DoctorVisit visit) {
    return _buildCard(
      title: "التشخيص",
      icon: Icons.medical_information_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: AppColor.mainBlue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColor.mainBlue.withOpacity(0.1),
              ),
            ),
            child: Text(
              visit.diagnosis,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.mainBlueDark,
                height: 1.5,
              ),
            ),
          ),
          16.H,
          Text(
            LocaleKeys.symptoms.tr(),
            style: TextStyles.font16DarkBlueW500,
          ),
          8.H,
          Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: AppColor.mainBlue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColor.mainBlue.withOpacity(0.1),
              ),
            ),
            child: Text(
              visit.symptoms,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.mainBlueDark,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentCard(DoctorVisit visit) {
    return _buildCard(
      title: "العلاج",
      icon: Icons.medical_services_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: AppColor.mainPink.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColor.mainPink.withOpacity(0.1),
              ),
            ),
            child: Text(
              visit.treatment,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.mainBlueDark,
                height: 1.5,
              ),
            ),
          ),
          16.H,
          Text(
            LocaleKeys.medicine.tr(),
            style: TextStyles.font16DarkBlueW500,
          ),
          8.H,
          ...visit.medications
              .split(',')
              .map((med) => _buildMedicationItem(med)),
        ],
      ),
    );
  }

  Widget _buildRecommendationsCard(DoctorVisit visit) {
    return _buildCard(
      title: "التوصيات",
      icon: Icons.lightbulb_outline,
      child: Column(
        children: visit.recommendations
            .map((rec) => _buildRecommendationItem(rec))
            .toList(),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainBlue.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(14.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.sp),
                  decoration: BoxDecoration(
                    color: AppColor.mainBlue.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    icon,
                    color: AppColor.mainBlue,
                    size: 18.sp,
                  ),
                ),
                8.W,
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.mainBlueDark,
                  ),
                ),
              ],
            ),
            12.H,
            child,
          ],
        ),
      ),
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
        Icon(
          icon,
          color: iconColor ?? AppColor.mainBlue,
          size: 22.sp,
        ),
        12.W,
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: textColor ?? AppColor.mainBlueDark,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMedicationItem(String medication) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.sp),
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: AppColor.mainPink.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColor.mainPink.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.medication_outlined,
            size: 20.sp,
            color: AppColor.mainPink,
          ),
          12.W,
          Expanded(
            child: Text(
              medication,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.mainBlueDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(String recommendation) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.sp),
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: AppColor.green.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColor.green.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 20.sp,
            color: AppColor.green,
          ),
          12.W,
          Expanded(
            child: Text(
              recommendation,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.mainBlueDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorInfoItem(IconData icon, String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.sp,
        vertical: 6.sp,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 16.sp,
          ),
          4.H,
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          2.H,
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}
