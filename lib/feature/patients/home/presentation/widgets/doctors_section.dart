import 'package:easy_localization/easy_localization.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/feature/patients/home/data/data.dart';
import 'package:healthy_sync/feature/patients/home/presentation/screens/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/feature/patients/home/presentation/widgets/card_doctor.dart';

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
        // عنوان القسم
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: AppColor.mainBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.medical_services_outlined,
                  color: AppColor.mainBlue,
                  size: 20.sp,
                ),
              ),
              12.W,
              Text(
                LocaleKeys.doctor.tr(),
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.mainBlueDark,
                ),
              ),
            ],
          ),
        ),
        // قائمة الأطباء
        GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          itemCount: doctors.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio:
                ResponsiveHelper.isMobile(context) ? 3.1.sp : 2.sp,
          ),
          itemBuilder: (context, index) {
            dynamic doctor = doctors[index];
            return CardDoctor(doctor: doctor, index: index).withTapEffect(
              onTap: () => context.push(DoctorDetails(doctor: doctor)),
            );
          },
        ),
      ],
    );
  }
}
