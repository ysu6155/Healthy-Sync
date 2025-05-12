import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';
import 'package:healthy_sync/feature/patients/home/presentation/screens/doctors_by_specialty_screen.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/feature/patients/home/data/data.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';

class SpecializationsAll extends StatelessWidget {
  const SpecializationsAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        toolbarHeight: 56.sp,
        title: Text(
          LocaleKeys.specializations.tr(),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // قسم البحث
          Container(
            margin: EdgeInsets.fromLTRB(16.sp, 16.sp, 16.sp, 12.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: AppColor.mainBlue.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // حقل البحث
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: Colors.grey[200]!,
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                          color: AppColor.mainBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.search_rounded,
                          color: AppColor.mainBlue,
                          size: 20.sp,
                        ),
                      ),
                      12.W,
                      Expanded(
                        child: CustomTextField(
                          hintText: "ابحث عن تخصص طبي...",
                          hintTextStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // قائمة التخصصات
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16.sp),
              itemCount: specializations.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1.1,
              ),
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
                              Text(
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
      decoration: BoxDecoration(
        color: isSelected ? AppColor.mainBlue : Colors.grey[100],
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isSelected ? AppColor.mainBlue : Colors.grey[300]!,
          width: 1.w,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[700],
          fontSize: 13.sp,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }
}
