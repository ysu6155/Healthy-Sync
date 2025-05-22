import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';
import 'package:healthy_sync/core/widgets/ui_helpers.dart';

class ChronicDiseasesScreen extends StatefulWidget {
  const ChronicDiseasesScreen({super.key});

  @override
  State<ChronicDiseasesScreen> createState() => _ChronicDiseasesScreenState();
}

class _ChronicDiseasesScreenState extends State<ChronicDiseasesScreen> {
  final List<String> _chronicDiseases = ['السكري', 'الضغط'];
  final TextEditingController _diseaseController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
  //     GlobalKey<ScaffoldMessengerState>();

  @override
  void dispose() {
    _diseaseController.dispose();
    super.dispose();
  }

  void _addDisease() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _chronicDiseases.add(_diseaseController.text);
        _diseaseController.clear();
        Navigator.of(context).pop();
        showSuccessSnackBar('تمت إضافة المرض بنجاح', context);
      });
    }
  }

  void _deleteDisease(int index) {
    final deletedDisease = _chronicDiseases[index];
    setState(() {
      _chronicDiseases.removeAt(index);
      showSuccessSnackBar('تم حذف المرض "$deletedDisease" بنجاح', context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldMessengerKey,
      appBar: AppBar(
        toolbarHeight: 48.sp,
        iconTheme: IconThemeData(color: AppColor.black, size: 24.sp),
        title: Text(
          'الأمراض المزمنة',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
        elevation: 0,
      ),
      body: _chronicDiseases.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.medical_services,
                    size: 60.sp,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16.sp),
                  Text(
                    'لا توجد أمراض مسجلة',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16.sp),
              itemCount: _chronicDiseases.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(bottom: 12.sp),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.sp,
                      vertical: 16.sp,
                    ),
                    leading: Container(
                      padding: EdgeInsets.all(8.sp),
                      decoration: BoxDecoration(
                        color: AppColor.mainBlue.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.medical_services,
                        color: AppColor.mainBlue,
                      ),
                    ),
                    title: Text(
                      _chronicDiseases[index],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red[400]),
                      onPressed: () => _showDeleteDialog(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.mainBlue,
        elevation: 4,
        onPressed: () => _showAddDiseaseDialog(),
        child: Icon(Icons.add, color: Colors.white, size: 28.sp),
      ),
    );
  }

  void _showAddDiseaseDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: AppColor.white,
            content: SizedBox(
              width: 300.w,
              child: Column(
                spacing: 16.sp,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'إضافة مرض مزمن',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: AppColor.mainBlueVaryDark,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: CustomTextField(
                      fillColor: AppColor.cardColor,
                      controller: _diseaseController,
                      hintText: "اسم المرض",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال اسم المرض';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            elevation: 4,
                            shadowColor: Colors.black,
                            backgroundColor: AppColor.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: AppColor.mainBlue,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'إلغاء',
                            style: TextStyle(
                              color: AppColor.mainBlue,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: AppColor.mainBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            elevation: 4, // ارتفاع الظل
                            shadowColor: Colors.black,
                          ),
                          onPressed: _addDisease,
                          child: Text(
                            'حفظ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text(
              'تأكيد الحذف',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(
              'هل أنت متأكد أنك تريد حذف مرض ${_chronicDiseases[index]}؟',
              textAlign: TextAlign.center,
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('إلغاء'),
                    ),
                  ),
                  8.W,
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () {
                        _deleteDisease(index);
                        Navigator.of(context).pop();
                      },
                      child: const Text('حذف'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
