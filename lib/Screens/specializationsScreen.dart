import 'package:flutter/material.dart';
import 'package:healthy_sync/Models/data_specializations.dart';
import 'package:healthy_sync/Screens/DoctorFilter.dart';
import 'package:healthy_sync/Themes/Themedata.dart';
import 'package:healthy_sync/unts/AppColor.dart';

class SpecializationsAll extends StatelessWidget {
  const SpecializationsAll ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Specializations",style: textButtomStyle,),
        iconTheme: IconThemeData(color: AppColor.white),
        backgroundColor: AppColor.main,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: specializations.length, // عدد التخصصات
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // عدد الأعمدة
                  crossAxisSpacing: 16, // المسافة الأفقية بين الكروت
                  mainAxisSpacing: 16, // المسافة الرأسية بين الكروت
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
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            specializations[index]['icon'] as IconData,
                            color: AppColor.white,
                            size: 40,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            specializations[index]['name'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
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
