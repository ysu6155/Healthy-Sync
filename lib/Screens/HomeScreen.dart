import 'package:flutter/material.dart';
import 'package:healthy_sync/Models/data_specializations.dart';
import 'package:healthy_sync/Screens/DoctorFilter.dart';
import 'package:healthy_sync/Screens/specializationsScreen.dart';
import 'package:healthy_sync/Widgets/DoctorVisitCard.dart';
import 'package:healthy_sync/Widgets/specializations.dart';
import 'package:healthy_sync/unts/AppColor.dart';

import '../Widgets/doctors_section.dart';
import '../Widgets/gradient.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/images/image1.png"),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello 👋",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Youssif Shaban",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColor.secondary,
                  child: IconButton(
                    icon: Icon(Icons.notifications,color: AppColor.white,),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            DoctorVisitCard(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "specializations",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SpecializationsAll();
                    }));
                  },
                  child: Text(
                    "See all",
                    style: TextStyle(
                      color: AppColor.main,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SpecializationsSection(),
            const SizedBox(height: 16),
            DoctorsSection(),
          ],
        ),
      ),
    );
  } }
