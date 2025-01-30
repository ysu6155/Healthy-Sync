import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/view/Screens/DoctorFilter/DoctorFilter.dart';
import 'package:healthy_sync/view_model/Models/data_specializations.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';

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
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (
                  context) {
                return DoctorFilterScreen(
                  selectedSpecialty: specializations[index]['name'] as String,);
              }));
            },
            child: Container(
              width: 100.w,
              padding:  EdgeInsets.all(16.sp),
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
                      size: 14.sp,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      specializations[index]['name'] as String,
                      style:  TextStyle(
                        color: AppColor.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) =>  SizedBox(width: 16.w),
        itemCount:  specializations.length, // عدد التخصصات
      ),
    );
  }
}
