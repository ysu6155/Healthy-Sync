import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/doctors_by_specialty/doctors_by_specialty_screen.dart';
import 'package:healthy_sync/core/Models/data_specializations.dart';
import 'package:healthy_sync/core/Themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';

class SpecializationsAll extends StatelessWidget {
  const SpecializationsAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.sp,
        title: Text(LocaleKeys.specializations.tr(), style: textStyle),
        iconTheme: IconThemeData(color: AppColor.white, size: 14.sp),
        backgroundColor: AppColor.main,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.H,
          Expanded(
            child: GridView.builder(
              itemCount: specializations.length, // عدد التخصصات
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // عدد الأعمدة
                crossAxisSpacing: 16.w, // المسافة الأفقية بين الكروت
                mainAxisSpacing: 16.sp, // المسافة الرأسية بين الكروت
                childAspectRatio: 1, // نسبة العرض إلى الارتفاع
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context.push(
                      DoctorsBySpecialtyScreen(
                        selectedSpecialty:
                            specializations[index]['name'] as String,
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.main,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          specializations[index]['icon'] as IconData,
                          color: AppColor.white,
                          size: 40.sp,
                        ),
                        8.H,
                        Text(
                          specializations[index]['name'] as String,
                          style: TextStyle(
                            color: AppColor.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ).paddingAll(16.sp),
    );
  }
}
