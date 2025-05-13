import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/feature/patients/home/data/data.dart';

import 'package:healthy_sync/feature/patients/home/presentation/screens/doctors_by_specialty_screen.dart';

class SpecializationsSection extends StatelessWidget {
  const SpecializationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 111.sp,
      child: ListView.separated(
        padding: EdgeInsetsDirectional.only(start: 16.sp),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context.push(
                DoctorsBySpecialtyScreen(
                  selectedSpecialty: specializations[index],
                ),
              );
            },
            child: Container(
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
                    color: const Color(0xFFCBD5E0).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // عناصر زخرفية محسنة
                  Positioned(
                    right: -20.w,
                    top: -20.h,
                    child: Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFFE2E8F0).withOpacity(0.4),
                            const Color(0xFFE2E8F0).withOpacity(0.1),
                          ],
                          stops: const [0.3, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -15.w,
                    bottom: -15.h,
                    child: Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFFE2E8F0).withOpacity(0.4),
                            const Color(0xFFE2E8F0).withOpacity(0.1),
                          ],
                          stops: const [0.3, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // محتوى البطاقة
                  Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFE2E8F0).withOpacity(0.6),
                                const Color(0xFFE2E8F0).withOpacity(0.4),
                              ],
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFCBD5E0).withOpacity(0.6),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            specializations[index]['icon'] as IconData,
                            size: 24.sp,
                            color: const Color(0xFF475569),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Expanded(
                          child: Text(
                            specializations[index]['name'] as String,
                            style: TextStyle(
                              color: const Color(0xFF1E293B),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.1,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => 16.W,
        itemCount: specializations.length,
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
