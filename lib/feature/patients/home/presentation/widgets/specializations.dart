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
                    AppColor.mainBlue,
                    AppColor.mainBlue.withOpacity(0.85),
                  ],
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.mainBlue.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // عناصر زخرفية
                  Positioned(
                    right: -10.w,
                    top: -10.h,
                    child: Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
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
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            specializations[index]['icon'] as IconData,
                            color: Colors.white,
                            size: 28.sp,
                          ),
                        ),
                        12.H,
                        Expanded(
                          child: Text(
                            specializations[index]['name'] as String,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              height: 1.2,
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
