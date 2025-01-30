import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/generated/l10n.dart';
import 'package:healthy_sync/view/Screens/DoctorFilter/DoctorFilter.dart';
import 'package:healthy_sync/view_model/Models/data_specializations.dart';
import 'package:healthy_sync/view_model/Themes/Themedata.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';

class SpecializationsAll extends StatelessWidget {
  const SpecializationsAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.sp,
        title: Text(
          S.of(context).specializations,
          style: textButtonStyle,
        ),
        iconTheme: IconThemeData(color: AppColor.white, size: 14.sp),
        backgroundColor: AppColor.main,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.sp),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorFilterScreen(
                            selectedSpecialty: specializations[index]['name']
                                as String, // إرسال اسم التخصص
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: AppColor.primaryGradient,
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
                          SizedBox(height: 8.sp),
                          Text(
                            specializations[index]['name'] as String,
                            style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp),
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
        ),
      ),
    );
  }
}
