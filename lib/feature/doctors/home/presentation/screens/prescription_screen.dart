import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';

import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/feature/doctors/home/data/prescription_data.dart';
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';

class PrescriptionScreen extends StatefulWidget {
  final Patient patient;

  const PrescriptionScreen({super.key, required this.patient});

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  final List<Map<String, TextEditingController>> _medications = [];
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _visitTypeController = TextEditingController();
  final TextEditingController _symptomsController = TextEditingController();
  final List<TextEditingController> _testControllers = [];

  @override
  void initState() {
    super.initState();
    _addMedication();
    _addTest();
  }

  @override
  void dispose() {
    for (var medication in _medications) {
      medication['name']?.dispose();
      medication['dosage']?.dispose();
      medication['duration']?.dispose();
    }
    for (var controller in _testControllers) {
      controller.dispose();
    }
    _notesController.dispose();
    _visitTypeController.dispose();
    _symptomsController.dispose();
    super.dispose();
  }

  void _addMedication() {
    setState(() {
      _medications.add({
        'name': TextEditingController(),
        'dosage': TextEditingController(),
        'duration': TextEditingController(),
      });
    });
  }

  void _removeMedication(int index) {
    setState(() {
      _medications[index]['name']?.dispose();
      _medications[index]['dosage']?.dispose();
      _medications[index]['duration']?.dispose();
      _medications.removeAt(index);
    });
  }

  void _addTest() {
    setState(() {
      _testControllers.add(TextEditingController());
    });
  }

  void _removeTest(int index) {
    setState(() {
      _testControllers[index].dispose();
      _testControllers.removeAt(index);
    });
  }

  void _savePrescription() {
    final medications =
        _medications
            .map(
              (med) => Medication(
                name: med['name']!.text,
                dosage: med['dosage']!.text,
                duration: med['duration']!.text,
              ),
            )
            .toList();

    final requiredTests =
        _testControllers
            .map((controller) => controller.text)
            .where((test) => test.isNotEmpty)
            .toList();

    final prescription = Prescription(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      patientId: widget.patient.id ?? '',
      doctorId: '1', // TODO: Get from auth
      date: DateTime.now(),
      visitType: _visitTypeController.text,
      symptoms: _symptomsController.text,
      requiredTests: requiredTests,
      medications: medications,
      notes: _notesController.text,
    );

    prescriptions.add(prescription);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: Text(
          'تسجيل روشته',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[200],
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الأعراض',
              style: TextStyles.font20WhiteBold.copyWith(color: AppColor.black),
            ),
            SizedBox(height: 16.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.grey.withValues(alpha: 0.3),
                    spreadRadius: 0.4,
                    blurRadius: 4.4,
                    offset: const Offset(0, 0.4),
                  ),
                ],
              ),
              child: TextField(
                controller: _symptomsController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'وصف الأعراض التي يشكو منها المريض...',
                  hintStyle: TextStyles.font12GreyW400,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.w),
                ),
                style: TextStyles.font12BlueW400.copyWith(
                  fontSize: ResponsiveHelper.isMobile(context) ? 16.sp : 24.sp,
                  color: AppColor.black,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'التحاليل المطلوبة',
              style: TextStyles.font20WhiteBold.copyWith(color: AppColor.black),
            ),
            SizedBox(height: 16.h),
            ..._testControllers.asMap().entries.map((entry) {
              final index = entry.key;
              final controller = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: controller,
                        hintText: 'اسم التحليل',
                      ),
                    ),
                    if (_testControllers.length > 1) ...[
                      SizedBox(width: 8.w),
                      IconButton(
                        onPressed: () => _removeTest(index),
                        icon: Icon(
                          Icons.delete,
                          color: AppColor.red,
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
            SizedBox(height: 8.h),
            CustomButton(
              name: "إضافة تحليل",
              onTap: _addTest,
              backgroundColor: AppColor.mainBlue,
            ),
            SizedBox(height: 24.h),
            Text(
              'الأدوية',
              style: TextStyles.font20WhiteBold.copyWith(color: AppColor.black),
            ),
            SizedBox(height: 16.h),
            ..._medications.asMap().entries.map((entry) {
              final index = entry.key;
              final medication = entry.value;
              return Card(
                margin: EdgeInsets.only(bottom: 16.h),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'دواء ${index + 1}',
                            style: TextStyles.font16DarkBlueW500,
                          ),
                          const Spacer(),
                          if (_medications.length > 1)
                            IconButton(
                              onPressed: () => _removeMedication(index),
                              icon: Icon(
                                Icons.delete,
                                color: AppColor.red,
                                size: 24.sp,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      CustomTextField(
                        controller: medication['name'],
                        hintText: 'اسم الدواء',
                      ),
                      SizedBox(height: 12.h),
                      CustomTextField(
                        controller: medication['dosage'],
                        hintText: 'الجرعة',
                      ),
                      SizedBox(height: 12.h),
                      CustomTextField(
                        controller: medication['duration'],
                        hintText: 'مدة الاستخدام',
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 16.h),
            CustomButton(
              name: "إضافة دواء",
              onTap: _addMedication,
              backgroundColor: AppColor.mainBlue,
            ),
            SizedBox(height: 24.h),
            Text(
              'ملاحظات',
              style: TextStyles.font20WhiteBold.copyWith(color: AppColor.black),
            ),
            SizedBox(height: 16.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.grey.withValues(alpha: 0.3),
                    spreadRadius: 0.4,
                    blurRadius: 4.4,
                    offset: const Offset(0, 0.4),
                  ),
                ],
              ),
              child: TextField(
                controller: _notesController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'أضف ملاحظات إضافية هنا...',
                  hintStyle: TextStyles.font12GreyW400,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.w),
                ),
                style: TextStyles.font12BlueW400.copyWith(
                  fontSize: ResponsiveHelper.isMobile(context) ? 16.sp : 24.sp,
                  color: AppColor.black,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            CustomButton(name: 'حفظ الروشته', onTap: _savePrescription),
          ],
        ),
      ),
    );
  }
}
