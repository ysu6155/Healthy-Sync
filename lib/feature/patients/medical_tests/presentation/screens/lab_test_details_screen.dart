import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';

class LabTestDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> testData;

  const LabTestDetailsScreen({
    super.key,
    required this.testData,
  });

  Future<void> _downloadReport(BuildContext context) async {
    try {
      // عرض مؤشر التحميل
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // محاكاة عملية التحميل
      await Future.delayed(const Duration(seconds: 2));

      // إغلاق مؤشر التحميل
      Navigator.pop(context);

      // عرض رسالة نجاح
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تم تحميل التقرير بنجاح',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColor.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      );
    } catch (e) {
      // إغلاق مؤشر التحميل في حالة الخطأ
      Navigator.pop(context);

      // عرض رسالة الخطأ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'حدث خطأ أثناء تحميل التقرير',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColor.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 56.sp,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "تفاصيل التحليل",
          style: TextStyles.font16DarkBlueW500,
        ),
        backgroundColor: AppColor.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة الأشعة
            Container(
              height: 200.sp,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: NetworkImage(testData['imageUrl'] ?? ''),
                  fit: BoxFit.cover,
                  onError: (_, __) => const Center(
                    child: Icon(Icons.image_not_supported_outlined),
                  ),
                ),
              ),
            ),
            24.H,
            // معلومات التحليل
            _buildInfoSection(
              title: "معلومات التحليل",
              children: [
                _buildInfoRow(
                  icon: Icons.science_outlined,
                  title: "نوع التحليل",
                  value: testData['type'] ?? '',
                  color: _getTypeColor(testData['type']),
                ),
                _buildInfoRow(
                  icon: Icons.description_outlined,
                  title: "وصف التحليل",
                  value: testData['description'] ?? '',
                ),
                _buildInfoRow(
                  icon: Icons.calendar_today_outlined,
                  title: "تاريخ التحليل",
                  value: testData['date'] ?? '',
                ),
                _buildInfoRow(
                  icon: Icons.person_outline,
                  title: "الطبيب",
                  value: testData['doctor'] ?? '',
                ),
              ],
            ),
            24.H,
            // نتائج التحليل
            _buildInfoSection(
              title: "نتائج التحليل",
              children: [
                if (testData['results'] != null)
                  ...(testData['results'] as List)
                      .map((result) => _buildResultItem(result)),
                Container(
                  padding: EdgeInsets.all(16.sp),
                  decoration: BoxDecoration(
                    color: AppColor.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColor.green.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: AppColor.green,
                            size: 20.sp,
                          ),
                          8.W,
                          Text(
                            "ملاحظات الطبيب",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.mainBlueDark,
                            ),
                          ),
                        ],
                      ),
                      8.H,
                      Text(
                        testData['notes'] ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColor.mainBlueDark,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            24.H,
            // زر تحميل التقرير
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _downloadReport(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.mainBlue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12.sp),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                icon: Icon(Icons.download_outlined, size: 20.sp),
                label: Text(
                  "تحميل التقرير",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultItem(Map<String, dynamic> result) {
    final isNormal = result['status'] == 'طبيعي';
    return Container(
      margin: EdgeInsets.only(bottom: 12.sp),
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: (isNormal ? AppColor.green : AppColor.orange).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: (isNormal ? AppColor.green : AppColor.orange).withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isNormal
                    ? Icons.check_circle_outline
                    : Icons.warning_amber_outlined,
                color: isNormal ? AppColor.green : AppColor.orange,
                size: 18.sp,
              ),
              8.W,
              Expanded(
                child: Text(
                  result['name'] ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.mainBlueDark,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.sp,
                  vertical: 4.sp,
                ),
                decoration: BoxDecoration(
                  color: (isNormal ? AppColor.green : AppColor.orange)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  result['status'] ?? '',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isNormal ? AppColor.green : AppColor.orange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          8.H,
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "النتيجة",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.grey,
                      ),
                    ),
                    4.H,
                    Text(
                      result['value'] ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColor.mainBlueDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "المعدل الطبيعي",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.grey,
                      ),
                    ),
                    4.H,
                    Text(
                      result['normalRange'] ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColor.mainBlueDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.font16DarkBlueW500.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        16.H,
        Container(
          padding: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    Color? color,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
              color: (color ?? AppColor.mainBlue).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              size: 20.sp,
              color: color ?? AppColor.mainBlue,
            ),
          ),
          12.W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColor.grey,
                  ),
                ),
                4.H,
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColor.mainBlueDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String? type) {
    switch (type) {
      case 'تحليل دم':
        return AppColor.mainBlue;
      case 'تحليل بول':
        return AppColor.mainPink;
      case 'تحليل براز':
        return AppColor.green;
      default:
        return AppColor.mainBlue;
    }
  }
}
