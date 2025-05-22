import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/feature/patients/home/presentation/doctors_by_specialty/screen/doctors_by_specialty_screen.dart';

class SpecializationsSection extends StatelessWidget {
  final List<Map<String, dynamic>> specializations;

  const SpecializationsSection({
    super.key,
    required this.specializations,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: specializations.length,
        padding: EdgeInsets.symmetric(
            vertical: ResponsiveHelper.isMobile(context) ? 16.w : 6.sp),
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final specialization = specializations[index];
          return Container(
            width: 120.w,
            height: 110.h,
            margin: EdgeInsets.only(left: index == 0 ? 16.w : 8.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  const Color(0xFFF8FAFC), // لون أبيض فاتح جداً
                  const Color(0xFFF1F5F9), // لون رمادي فاتح جداً
                  const Color(0xFFE2E8F0), // لون رمادي فاتح
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFCBD5E0).withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                context.push(
                  DoctorsBySpecialtyScreen(
                    selectedSpecialty: specialization,
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  4.H,
                  Container(
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                      color: AppColor.mainBlue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      specialization['icon'] as IconData,
                      color: AppColor.mainBlue,
                      size: 24.sp,
                    ),
                  ),
                  8.H,
                  Expanded(
                    child: Text(
                      specialization['name'] as String,
                      style: TextStyles.font16DarkBlueW500,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

List colorSpecializations = [
  const Color(0xFFF8FAFC), // أبيض فاتح جداً
  const Color(0xFFF1F5F9), // رمادي فاتح جداً
  const Color(0xFFE2E8F0), // رمادي فاتح
  const Color(0xFFCBD5E0), // رمادي متوسط
  const Color(0xFF94A3B8), // رمادي غامق
  const Color(0xFF64748B), // رمادي داكن
  const Color(0xFF475569), // رمادي داكن جداً
  const Color(0xFF334155), // رمادي أسود
  const Color(0xFF1E293B), // أسود رمادي
  const Color(0xFF0F172A), // أسود داكن
];
