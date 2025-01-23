import 'package:flutter/material.dart';
import 'package:healthy_sync/Models/data_Doctors.dart';
import 'package:healthy_sync/Screens/DoctorDetails.dart';
import 'package:healthy_sync/unts/AppColor.dart';

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
              "Doctors",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.black,
              ),
            ),
            const SizedBox(height: 16),

            // الشبكة التي تعرض الأطباء
            GridView.builder(
              itemCount: doctors.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // عدد الأعمدة
                crossAxisSpacing: 16, // المسافة الأفقية بين العناصر
                mainAxisSpacing: 16, // المسافة الرأسية بين العناصر
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
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(doctor["image"]!),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            doctor["name"]!,
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            doctor["specialty"]!,
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              double rat = doctor["rating"] ?? 0;
                              return Icon(
                                Icons.star,
                                color: index < rat
                                    ? Colors.amber
                                    : Colors.grey, // نجمة ملونة أو فارغة
                                size: 20,
                              );
                            }),
                          )
                        ],
                      ),
                    ));
              },
            ),
          ],

    );
  }
}
