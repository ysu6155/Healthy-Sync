import 'package:flutter/material.dart';
import 'package:healthy_sync/Themes/Themedata.dart';
import 'package:healthy_sync/Widgets/Button.dart';
import 'package:healthy_sync/unts/AppColor.dart';

class DoctorDetails extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorDetails({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctor["name"], style: textButtomStyle),
        iconTheme:  IconThemeData(color: AppColor.white),
        backgroundColor: AppColor.main,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(doctor["image"]),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Name: ${doctor["name"]}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Specialty: ${doctor["specialty"]}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  "Rating: ${doctor["rating"]}/5.0",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "About Doctor:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              doctor["about"] ?? "No additional information provided.",
              style: const TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 16,
            ),
            Button(
              name: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Call Doctor",style: textButtomStyle,),
                  SizedBox(width: 8),
                  Icon(Icons.call,color: AppColor.white,),
                ],
              ),
              onTap: () {},
            ),
            SizedBox(
              height: 8,
            ),
            Button(
              name: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Chat with Doctor",style: textButtomStyle,),
                  SizedBox(width: 8),
                  Icon(Icons.chat,color: AppColor.white,),
                ],
              ),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
