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
          return Ink(
            width: 100.w,
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: AppColor.mainPink, //colorSpecializations[index],
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              specializations[index]['icon'] as IconData,
              color: AppColor.white,
              size: 30.sp,
            ),
          ).withTapEffect(
            onTap: () => context.push(
              DoctorsBySpecialtyScreen(
                selectedSpecialty: specializations[index],
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
  AppColor.mainPink,
  AppColor.mainBlue,
  AppColor.blue,
  AppColor.green,
  AppColor.purple,
  AppColor.pink,
  AppColor.orange,
  AppColor.red,
  AppColor.brown,
  AppColor.teal,
];
