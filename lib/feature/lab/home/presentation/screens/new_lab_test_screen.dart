import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';
import 'package:healthy_sync/feature/lab/home/data/pdf_service.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';

class NewLabTestScreen extends StatefulWidget {
  final Patient patient;

  const NewLabTestScreen({super.key, required this.patient});

  @override
  State<NewLabTestScreen> createState() => _NewLabTestScreenState();
}

class _NewLabTestScreenState extends State<NewLabTestScreen> {
  final TextEditingController _testNameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String? _selectedTestType;
  String? _selectedStatus;
  File? _selectedFile;

  final List<String> _testTypes = [
    'تحليل دم شامل',
    'تحليل سكر',
    'تحليل وظائف الكبد',
    'تحليل وظائف الكلى',
    'تحليل الدهون',
    'تحليل هرمونات',
    'تحليل فيتامينات',
    'تحليل معادن',
  ];

  final List<String> _testStatuses = [
    'طبيعي',
    'مرتفع',
    'منخفض',
    'غير طبيعي',
    'يحتاج متابعة',
  ];

  @override
  void dispose() {
    _testNameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ أثناء اختيار الملف: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _saveTest() async {
    if (_selectedTestType == null || _selectedStatus == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('الرجاء اختيار نوع التحليل وحالته'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final labTest = LabTestPDF(
        testName: _testNameController.text,
        testType: _selectedTestType!,
        date: DateTime.now(),
        notes: _notesController.text,
        patient: widget.patient,
      );

      final file = await PDFService.generateLabTestPDF(labTest);
      await OpenFile.open(file.path);

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ أثناء إنشاء التقرير: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: Text(
          'تسجيل تحليل جديد',
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
            _buildPatientInfo(),
            SizedBox(height: 20.h),
            _buildTestDetails(),
            SizedBox(height: 20.h),
            _buildFileUpload(),
            SizedBox(height: 20.h),
            _buildNotes(),
            SizedBox(height: 30.h),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientInfo() {
    return Card(
      color: AppColor.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'معلومات المريض',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Icon(Icons.person, color: AppColor.mainBlue, size: 18.sp),
                SizedBox(width: 10.w),
                Text(
                  widget.patient.name ?? '',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(Icons.phone, color: AppColor.mainBlue, size: 18.sp),
                SizedBox(width: 10.w),
                Text(
                  widget.patient.phone ?? '',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestDetails() {
    return Card(
      color: AppColor.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'تفاصيل التحليل',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15.h),
            DropdownButtonFormField<String>(
              value: _selectedTestType,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
              icon: Icon(Icons.arrow_drop_down, color: AppColor.mainBlue),
              decoration: InputDecoration(
                labelText: 'نوع التحليل',
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.mainBlue),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.mainBlue),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.mainBlue),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.mainBlue),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              items: _testTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(
                    type,
                    style: TextStyle(
                      color: _selectedTestType == type
                          ? Colors.black
                          : Colors.grey,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedTestType = newValue;
                  });
                }
              },
            ),
            SizedBox(height: 15.h),
            CustomTextField(
              controller: _testNameController,
              labelText: 'اسم التحليل',
              hintText: 'أدخل اسم التحليل',
            ),
            SizedBox(height: 15.h),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
              icon: Icon(Icons.arrow_drop_down, color: AppColor.mainBlue),
              decoration: InputDecoration(
                labelText: 'حالة التحليل',
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.mainBlue),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.mainBlue),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.mainBlue),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.mainBlue),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              items: _testStatuses.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(
                    status,
                    style: TextStyle(
                      color: _selectedStatus == status
                          ? Colors.black
                          : Colors.grey,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedStatus = newValue;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileUpload() {
    return Card(
      color: AppColor.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'إضافة ملف',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15.h),
            InkWell(
              onTap: _pickFile,
              child: Container(
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(Icons.upload_file, color: AppColor.mainBlue),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        _selectedFile?.path.split('/').last ?? 'إضافة ملف',
                        style: TextStyle(fontSize: 16.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_selectedFile != null) ...[
              SizedBox(height: 10.h),
              Text(
                'تم إضافة الملف: ${_selectedFile!.path.split('/').last}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.green,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNotes() {
    return Card(
      color: AppColor.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ملاحظات',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15.h),
            CustomTextField(
              controller: _notesController,
              labelText: 'ملاحظات إضافية',
              hintText: 'أدخل أي ملاحظات إضافية',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return CustomButton(
      width: double.infinity,
      height: 50.h,
      name: 'حفظ التحليل',
      onTap: _saveTest,
      backgroundColor: AppColor.mainBlue,
    );
  }
}
