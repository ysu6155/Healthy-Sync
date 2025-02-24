import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/doctors_by_specialty/doctors_by_specialty_screen.dart';
import 'package:healthy_sync/core/Models/data_specializations.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/core/utils/app_color.dart';

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
          // إنشاء الكارد لكل تخصص
          return Ink(
            width: 100.w,
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              gradient: AppColor.primaryGradient,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Icon(
                    specializations[index]['icon'] as IconData,
                    color: AppColor.white,
                    size: 18.sp,
                  ),
                ),
                Expanded(
                  child: Text(
                    specializations[index]['name'] as String,
                    style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ).withTapEffect(
              onTap: () => context.push(DoctorsBySpecialtyScreen(
                    selectedSpecialty: specializations[index]['name'] as String,
                  )));
        },
        separatorBuilder: (context, index) => 16.W,
        itemCount: specializations.length, // عدد التخصصات
      ),
    );
  }
}
