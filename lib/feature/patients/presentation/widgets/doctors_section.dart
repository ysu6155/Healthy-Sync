import 'package:easy_localization/easy_localization.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/doctor_details/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/Models/data_doctors.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_color.dart';

class DoctorsSection extends StatefulWidget {
  const DoctorsSection({super.key});

  @override
  State<DoctorsSection> createState() => _DoctorsSectionState();
}

class _DoctorsSectionState extends State<DoctorsSection> {

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان الصفحة
            Text(
              LocaleKeys.doctor.tr(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.black,
              ),
            ),
            16.H,

            // الشبكة التي تعرض الأطباء
            GridView.builder(
              itemCount: doctors.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // عدد الأعمدة
                crossAxisSpacing: 16.w, // المسافة الأفقية بين العناصر
                mainAxisSpacing: 16.sp, // المسافة الرأسية بين العناصر
              ),
              itemBuilder: (context, index) {
                dynamic doctor = doctors[index];
                return Ink(
                  decoration: BoxDecoration(
                    gradient: AppColor.primaryGradient,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundImage: AssetImage(doctor["image"]!),
                      ),
                      8.H,
                      Text(
                        doctor["name"]!,
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        doctor["specialty"]!,
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 14.sp,
                        ),
                      ),
                     8.H,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          double rat = doctor["rating"] ?? 0;
                          return Icon(
                            Icons.star,
                            color: index < rat
                                ? AppColor.amber
                                : AppColor.grey, // نجمة ملونة أو فارغة
                            size: 20.sp,
                          );
                        }),
                      )
                    ],
                  ),
                ).withTapEffect(onTap: () => context.push(DoctorDetails(doctor: doctor),) );
              },
            ),
          ],

    ).paddingSymmetric(horizontal: 16.w);
  }
}
