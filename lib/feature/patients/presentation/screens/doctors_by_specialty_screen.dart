import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/doctor_details.dart';
import 'package:healthy_sync/core/Models/data_doctors.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/feature/patients/presentation/widgets/card_doctor.dart';

class DoctorsBySpecialtyScreen extends StatefulWidget {
  final Map selectedSpecialty;

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

  void filterDoctors(Map specialty) {
    setState(() {
      filteredDoctors =
          doctors.where((doctor) {
            return doctor["specialty"] == specialty["name"]; // مقارنة صحيحة
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48.sp,
        title: Row(
          children: [
            Text("${widget.selectedSpecialty["name"]} ", style: textStyleTitle),
            8.W,
            Icon(widget.selectedSpecialty["icon"], size: 24.sp),
          ],
        ),
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
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.sp,
                  childAspectRatio: .83.sp,
                ),
                itemBuilder: (context, index) {
                  dynamic doctor = filteredDoctors[index];
                  return CardDoctor(doctor: doctor, index: index).withTapEffect(
                    onTap: () {
                      context.push(DoctorDetails(doctor: doctor));
                    },
                  );
                },
              ),
    );
  }

  Ink newMethod(doctor) {
    return Ink(
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: AppColor.main,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundImage: Image.network(doctor["image"]).image,
          ),
          8.H,
          Text(doctor["name"]!, style: textStyleBody),
          8.H,
          Text(doctor["specialty"]!, style: textStyle),
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
    );
  }
}
