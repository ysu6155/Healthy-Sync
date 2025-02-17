import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/view_model/utils/app_color.dart';
import 'package:healthy_sync/view_model/utils/extensions.dart';

class TreatmentSchedulePage extends StatefulWidget {
  const TreatmentSchedulePage({super.key});

  @override
  TreatmentSchedulePageState createState() => TreatmentSchedulePageState();
}

class TreatmentSchedulePageState extends State<TreatmentSchedulePage> {
  void showAddTreatmentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nameController = TextEditingController();
        TimeOfDay selectedTime = TimeOfDay(hour: 8, minute: 0);

        return AlertDialog(
          title: Text('إضافة علاج جديد'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'اسم العلاج'),
              ),
              ListTile(
                title: Text('الوقت: ${selectedTime.format(context)}'),
                trailing: Icon(Icons.access_time),
                onTap: () async {
                  selectedTime = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      ) ??
                      selectedTime;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  treatments.add(
                    Treatment(
                      time: selectedTime,
                      name: nameController.text,
                      type: TreatmentType.medication, // يمكن تغيير النوع
                    ),
                  );
                });
                Navigator.of(context).pop();
              },
              child: Text('إضافة'),
            ),
          ],
        );
      },
    );
  }


  List<Treatment> treatments = [
    Treatment(
      time: TimeOfDay(hour: 9, minute: 0),
      name: 'مضاد حيوي (500mg)',
      type: TreatmentType.medication,
    ),
    Treatment(
      time: TimeOfDay(hour: 11, minute: 59),
      name: 'فحص سكر الدم',
      type: TreatmentType.test,
    ),
    Treatment(
      time: TimeOfDay(hour: 15, minute: 0),
      name: 'حقنة أنسولين',
      type: TreatmentType.medication,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.main,
        title: Text(
          'جدول العلاج اليومي',
          style: TextStyle(color: AppColor.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_alert, color: AppColor.white),
            onPressed: showAddTreatmentDialog,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: ListView(
          children: [
            buildColorGuide(),
            buildCalendarHeader(),
            20.H,
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,

                physics: NeverScrollableScrollPhysics(),
                itemCount: treatments.length,
                itemBuilder: (context, index) =>
                    buildTreatmentCard(treatments[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildCalendarHeader() {
    return Card(
      child: Padding(
        padding:  EdgeInsets.all(16.0.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${getDayOfWeek()} - ${DateTime.now().day} ${getArabicMonthName(DateTime.now().month)} ${DateTime.now().year}',
              style: TextStyle(fontSize: 18.sp),
            ),
            Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  String getDayOfWeek() {
    final days = [
      'الأحد',
      'الإثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت'
    ];
    return days[DateTime.now().weekday - 1];
  }

  Widget buildTreatmentCard(Treatment treatment) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
        side: BorderSide(
          color: getBorderColor(treatment),
          width: 3.w,
        ),
      ),
      color: getBackgroundColor(treatment),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.sp),
        title: Text(
          treatment.name,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        subtitle: Text(
          'الوقت: ${formatTimeOfDay(treatment.time)}',
          style: TextStyle(color: Colors.black),
        ),
        trailing: treatment.isCompleted
            ? Icon(Icons.check_circle, color: Colors.green)
            : IconButton(
                icon: Icon(Icons.check_circle_outline, color: Colors.white),
                onPressed: () => markCompleted(treatment),
              ),
      ),
    );
  }

  Color getBackgroundColor(Treatment treatment) {
    final now = TimeOfDay.now();
    final nowMinutes = now.hour * 60 + now.minute;
    final treatmentMinutes = treatment.time.hour * 60 + treatment.time.minute;

    if (treatment.isCompleted) {
      return AppColor.greenShade100;
    }

    if (nowMinutes > treatmentMinutes) {
      return AppColor.redShade200;
    }

    if (treatmentMinutes - nowMinutes <= 30) {
      return AppColor.orangeShade200;
    }

    return AppColor.greenShade100;
  }

  Color getBorderColor(Treatment treatment) {
    final now = TimeOfDay.now();
    final nowMinutes = now.hour * 60 + now.minute;
    final treatmentMinutes = treatment.time.hour * 60 + treatment.time.minute;

    if (nowMinutes > treatmentMinutes) {
      return AppColor.red;
    } else if (treatmentMinutes - nowMinutes <= 30) {
      return AppColor.orange;
    } else {
      return AppColor.greenShade800;
    }
  }

  String formatTimeOfDay(TimeOfDay time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }

  String getArabicMonthName(int month) {
    final months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر'
    ];
    return months[month - 1];
  }

  void markCompleted(Treatment treatment) {
    setState(() {
      if (!treatment.isCompleted) {
        treatment.isCompleted = true;
        treatments.remove(treatment);
        treatments.add(treatment);
      }
    });
  }

  Widget buildColorGuide() {
    return Card(
      child: Padding(
        padding:  EdgeInsets.all(16.0.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildColorBox(AppColor.greenShade800, 'الموعد قادم'),
            buildColorBox(AppColor.red, 'مر الوقت'),
            buildColorBox(AppColor.orange, 'الموعد قريب'),
          ],
        ),
      ),
    );
  }

  Widget buildColorBox(Color color, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 10.r,
          backgroundColor: color,
        ),
      8.H,
        Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.black)),
      ],
    );
  }
}

enum TreatmentType { medication, test, physio }

class Treatment {
  final TimeOfDay time;
  final String name;
  final TreatmentType type;
  bool isCompleted = false;

  Treatment({
    required this.time,
    required this.name,
    required this.type,
    this.isCompleted = false,
  });
}
