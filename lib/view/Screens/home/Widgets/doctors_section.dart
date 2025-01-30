import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/generated/l10n.dart';
import 'package:healthy_sync/view/Screens/DoctorDetails/DoctorDetails.dart';
import 'package:healthy_sync/view_model/Models/data_Doctors.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';

class DoctorsSection extends StatefulWidget {
  const DoctorsSection({super.key});

  @override
  State<DoctorsSection> createState() => _DoctorsSectionState();
}

class _DoctorsSectionState extends State<DoctorsSection> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.0.sp),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // عنوان الصفحة
              Text(
                S.of(context).doctor,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
               SizedBox(height: 16.sp),

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
                  return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return DoctorDetails(doctor: doctor);
                        }));
                      },
                      child: Container(
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
                             SizedBox(height: 8.sp),
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
                             SizedBox(height: 8.sp),
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
                      ));
                },
              ),
            ],

      ),
    );
  }
}
