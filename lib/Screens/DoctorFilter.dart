import 'package:flutter/material.dart';
import 'package:healthy_sync/Models/data_Doctors.dart';
import 'package:healthy_sync/Screens/DoctorDetails.dart';
import 'package:healthy_sync/Themes/Themedata.dart';
import 'package:healthy_sync/unts/AppColor.dart';

class DoctorFilterScreen extends StatefulWidget {
  final String selectedSpecialty;

  const DoctorFilterScreen({super.key, required this.selectedSpecialty});

  @override
  State<DoctorFilterScreen> createState() => _DoctorFilterScreenState();
}

class _DoctorFilterScreenState extends State<DoctorFilterScreen> {
  late List<dynamic> filteredDoctors;

  @override
  void initState() {
    super.initState();
    filterDoctors(widget.selectedSpecialty);
  }

  // تصفية الأطباء بناءً على التخصص
  void filterDoctors(String specialty) {
    setState(() {
      filteredDoctors = doctors.where((doctor) {
        return doctor["specialty"] == specialty;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedSpecialty,style: textButtomStyle,),
        iconTheme:  IconThemeData(color: AppColor.white),
        backgroundColor: AppColor.main,
      ),
      body: filteredDoctors.isEmpty
          ? const Center(
        child: Text("No doctors found for this specialty"),
      )
          : GridView.builder(
            itemCount: filteredDoctors.length,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // عدد الأعمدة
                      crossAxisSpacing: 16, // المسافة الأفقية بين العناصر
                      mainAxisSpacing: 16, // المسافة الرأسية بين العناصر
            ),
            itemBuilder: (context, index) {
                      dynamic doctor = filteredDoctors[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
            MaterialPageRoute(builder: (context) {
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
            ),
          ],
                          ),
                        ),
                      );
            },
          ),
    );
  }
}
