import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/feature/patients/home/data/data.dart';
import 'package:healthy_sync/feature/patients/home/presentation/screens/doctor_details.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/feature/patients/home/presentation/widgets/card_doctor.dart';

class DoctorsBySpecialtyScreen extends StatefulWidget {
  final Map selectedSpecialty;

  const DoctorsBySpecialtyScreen({super.key, required this.selectedSpecialty});

  @override
  State<DoctorsBySpecialtyScreen> createState() =>
      _DoctorsBySpecialtyScreenState();
}

class _DoctorsBySpecialtyScreenState extends State<DoctorsBySpecialtyScreen> {
  String? selectedSpecialty;
  List<Map<String, dynamic>> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    // بص يا جو، هنا بناخد التخصص اللي جاي من الصفحة اللي قبليها
    selectedSpecialty = widget.selectedSpecialty["value"];
    filterDoctors();
  }

  void filterDoctors() {
    // بص يا جو، هنا بنفلتر الدكاترة اللي تخصصهم بيساوي التخصص المختار
    filteredDoctors = doctors
        .where((doctor) => doctor['specialty'] == selectedSpecialty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48.sp,
        title: Row(
          children: [
            Text(
              "${widget.selectedSpecialty["name"]}",
              style: TextStyles.font20WhiteBold,
            ),
            8.W,
            Icon(widget.selectedSpecialty["icon"], size: 24.sp),
          ],
        ),
        iconTheme: IconThemeData(color: AppColor.white, size: 16.sp),
        backgroundColor: AppColor.mainBlue,
      ),
      body: filteredDoctors.isEmpty
          ? Center(
              child: Text(
                "لا يوجد أطباء لهذا التخصص",
                style: TextStyles.font16DarkBlueW500,
              ),
            )
          : GridView.builder(
              itemCount: filteredDoctors.length,
              padding: EdgeInsets.symmetric(
                horizontal: 16.sp,
                vertical: 16.w,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.sp,
                childAspectRatio:
                    ResponsiveHelper.isMobile(context) ? 3.1.sp : 1.6.sp,
              ),
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                return CardDoctor(doctor: doctor, index: index).withTapEffect(
                  onTap: () {
                    context.push(DoctorDetails(doctor: doctor));
                  },
                );
              },
            ),
    );
  }
}
