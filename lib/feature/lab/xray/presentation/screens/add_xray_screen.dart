import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class AddXrayScreen extends StatefulWidget {
  final Patient patient;

  const AddXrayScreen({super.key, required this.patient});

  @override
  State<AddXrayScreen> createState() => _AddXrayScreenState();
}

class _AddXrayScreenState extends State<AddXrayScreen> {
  final TextEditingController _xrayTypeController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String? _selectedStatus;
  String? _selectedXrayType;
  File? _selectedImage;
  File? _selectedReport;

  final List<String> _xrayTypes = [
    'أشعة سينية',
    'أشعة مقطعية',
    'رنين مغناطيسي',
    'أشعة بالموجات فوق الصوتية',
    'أشعة بالصبغة',
    'أشعة الثدي',
    'أشعة الأسنان',
  ];

  final List<String> _xrayStatuses = [
    'طبيعي',
    'غير طبيعي',
    'يحتاج متابعة',
    'حالة حرجة',
  ];

  @override
  void dispose() {
    _xrayTypeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ أثناء اختيار الصورة: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _pickReport() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null) {
        setState(() {
          _selectedReport = File(result.files.single.path!);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ أثناء اختيار التقرير: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _saveXray() {
    // TODO: Implement save functionality
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: Text(
          'إضافة أشعة جديدة',
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
            _buildXrayDetails(),
            SizedBox(height: 20.h),
            _buildImageUpload(),
            SizedBox(height: 20.h),
            _buildReportUpload(),
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

  Widget _buildXrayDetails() {
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
              'تفاصيل الأشعة',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15.h),
            DropdownButtonFormField<String>(
              icon: Icon(Icons.arrow_drop_down, color: AppColor.mainBlue),
              value: _selectedXrayType,
              decoration: InputDecoration(
                labelText: 'نوع الأشعة',
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
              ),
              style: TextStyle(
                color: _selectedXrayType == Null ? Colors.grey : Colors.black,
                fontSize: 16.sp,
              ),
              items: _xrayTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _xrayTypeController.text = newValue;
                  });
                }
              },
            ),
            SizedBox(height: 15.h),
            CustomTextField(
              controller: _xrayTypeController,
              labelText: 'نوع الأشعة',
              hintText: 'أدخل نوع الأشعة',
            ),
            SizedBox(height: 15.h),
            DropdownButtonFormField<String>(
              icon: Icon(Icons.arrow_drop_down, color: AppColor.mainBlue),
              value: _selectedStatus,
              decoration: InputDecoration(
                labelText: 'حالة الأشعة',
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
              ),
              style: TextStyle(
                color: _selectedStatus == null ? Colors.grey : Colors.black,
                fontSize: 16.sp,
              ),
              items: _xrayStatuses.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
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

  Widget _buildImageUpload() {
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
              'إضافة صورة الأشعة',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15.h),
            InkWell(
              onTap: _pickImage,
              child: Container(
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(Icons.image, color: AppColor.mainBlue),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        _selectedImage?.path.split('/').last ?? 'إضافة صورة',
                        style: TextStyle(fontSize: 16.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_selectedImage != null) ...[
              SizedBox(height: 10.h),
              Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    image: FileImage(_selectedImage!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildReportUpload() {
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
              'إضافة تقرير الأشعة',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15.h),
            InkWell(
              onTap: _pickReport,
              child: Container(
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(Icons.description, color: AppColor.mainBlue),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        _selectedReport?.path.split('/').last ?? 'إضافة تقرير',
                        style: TextStyle(fontSize: 16.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_selectedReport != null) ...[
              SizedBox(height: 10.h),
              Text(
                'تم اختيار التقرير: ${_selectedReport!.path.split('/').last}',
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
      name: 'حفظ الأشعة',
      onTap: _saveXray,
      backgroundColor: AppColor.mainBlue,
    );
  }
}
