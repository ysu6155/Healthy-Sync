import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';

class TreatmentScheduleScreen extends StatefulWidget {
  const TreatmentScheduleScreen({super.key});

  @override
  _TreatmentScheduleScreenState createState() =>
      _TreatmentScheduleScreenState();
}

class _TreatmentScheduleScreenState extends State<TreatmentScheduleScreen> {
  List<Map<String, dynamic>> medications = [
    {"time": "08:00 AM", "name": "Panadol", "taken": false},
    {"time": "02:00 PM", "name": "Augmentin", "taken": false},
    {"time": "08:00 PM", "name": "Vitamin C", "taken": true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.dailyTreatmentSchedule.tr(),
          style: TextStyle(color: AppColor.black),
        ),
        backgroundColor: AppColor.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: medications.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(
                        medications[index]["taken"]
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color:
                            medications[index]["taken"]
                                ? AppColor.green
                                : AppColor.grey,
                      ),
                      title: Text(medications[index]["name"]),
                      subtitle: Text(medications[index]["time"]),
                      trailing: Switch(
                        activeColor: AppColor.secondary,
                        inactiveThumbColor: AppColor.grey,
                        value: medications[index]["taken"],
                        onChanged: (value) {
                          setState(() {
                            medications[index]["taken"] = value;
                          });
                        },
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
