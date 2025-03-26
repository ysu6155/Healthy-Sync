import 'package:easy_localization/easy_localization.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/Models/data_doctors.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/feature/patients/presentation/widgets/card_doctor.dart';

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
        Text(
          LocaleKeys.doctor.tr(),
          style: TextStyles.font20WhiteBold.copyWith(color: AppColor.black),
        ),
        16.H,

        GridView.builder(
          itemCount: doctors.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.sp,
            childAspectRatio: 3.6.sp,
          ),
          itemBuilder: (context, index) {
            dynamic doctor = doctors[index];
            return CardDoctor(doctor: doctor, index: index).withTapEffect(
              onTap: () => context.push(DoctorDetails(doctor: doctor)),
            );
          },
        ),
      ],
    ).paddingSymmetric(horizontal: 16.w);
  }
}
