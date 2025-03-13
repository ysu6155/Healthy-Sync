import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/doctor_details/doctor_details.dart';
import 'package:healthy_sync/core/Models/data_doctors.dart';
import 'package:healthy_sync/core/Themes/light_theme.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';

class DoctorsBySpecialtyScreen extends StatefulWidget {
  final String selectedSpecialty;

  const DoctorsBySpecialtyScreen({super.key, required this.selectedSpecialty});

  @override
  State<DoctorsBySpecialtyScreen> createState() =>
      _DoctorsBySpecialtyScreenState();
}

class _DoctorsBySpecialtyScreenState extends State<DoctorsBySpecialtyScreen> {
  late List<dynamic> filteredDoctors;

  @override
  void initState() {
    super.initState();
    filterDoctors(widget.selectedSpecialty);
  }

  // تصفية الأطباء بناءً على التخصص
  void filterDoctors(String specialty) {
    setState(() {
      filteredDoctors =
          doctors.where((doctor) {
            return doctor["specialty"] == specialty;
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48.sp,
        title: Text(widget.selectedSpecialty, style: textStyle),
        iconTheme: IconThemeData(color: AppColor.white, size: 16.sp),
        backgroundColor: AppColor.main,
      ),
      body:
          filteredDoctors.isEmpty
              ? Center(child: Text("No doctors found for this specialty"))
              : GridView.builder(
                itemCount: filteredDoctors.length,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.sp,
                  vertical: 16.w,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // عدد الأعمدة
                  crossAxisSpacing: 16.w, // المسافة الأفقية بين العناصر
                  mainAxisSpacing: 16.sp, // المسافة الرأسية بين العناصر
                ),
                itemBuilder: (context, index) {
                  dynamic doctor = filteredDoctors[index];
                  return Ink(
                    decoration: BoxDecoration(
                      color: AppColor.main,
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
                              color:
                                  index < rat
                                      ? AppColor.amber
                                      : AppColor.grey, // نجمة ملونة أو فارغة
                              size: 20.sp,
                            );
                          }),
                        ),
                      ],
                    ),
                  ).withTapEffect(
                    onTap: () {
                      context.push(DoctorDetails(doctor: doctor));
                    },
                  );
                },
              ),
    );
  }
}
