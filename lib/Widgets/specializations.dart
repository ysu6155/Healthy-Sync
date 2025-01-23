import 'package:flutter/material.dart';
import 'package:healthy_sync/Models/data_specializations.dart';
import 'package:healthy_sync/Screens/DoctorFilter.dart';
import 'package:healthy_sync/unts/AppColor.dart';

class SpecializationsSection extends StatelessWidget {
  const SpecializationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 111,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // إنشاء الكارد لكل تخصص
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (
                  context) {
                return DoctorFilterScreen(
                  selectedSpecialty: specializations[index]['name'] as String,);
              }));
            },
            child: Container(
              width: 111,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: AppColor.primaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Icon(
                      specializations[index]['icon'] as IconData,
                      color: AppColor.white,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      specializations[index]['name'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount:  specializations.length, // عدد التخصصات
      ),
    );
  }
}
