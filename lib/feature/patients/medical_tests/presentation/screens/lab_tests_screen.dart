import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/feature/patients/medical_tests/data/dummy_data.dart';
import 'package:healthy_sync/feature/patients/medical_tests/presentation/screens/lab_test_details_screen.dart';

class LabTestsScreen extends StatefulWidget {
  const LabTestsScreen({super.key});

  @override
  State<LabTestsScreen> createState() => _LabTestsScreenState();
}

class _LabTestsScreenState extends State<LabTestsScreen> {
  String selectedFilter = 'الكل';
  DateTimeRange? customDateRange;
  final List<String> filters = [
    'الكل',
    'هذا الشهر',
    'آخر 3 أشهر',
    'هذا العام',
    'فترة مخصصة'
  ];

  List<Map<String, dynamic>> get filteredLabTests {
    if (selectedFilter == 'الكل') return MedicalTestsData.labTests;
    if (selectedFilter == 'فترة مخصصة' && customDateRange != null) {
      return MedicalTestsData.labTests.where((test) {
        final testDate = DateTime.parse(test['date']);
        return testDate.isAfter(
                customDateRange!.start.subtract(const Duration(days: 1))) &&
            testDate
                .isBefore(customDateRange!.end.add(const Duration(days: 1)));
      }).toList();
    }

    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month);
    final threeMonthsAgo = DateTime(now.year, now.month - 3);
    final startOfYear = DateTime(now.year);

    return MedicalTestsData.labTests.where((test) {
      final testDate = DateTime.parse(test['date']);
      switch (selectedFilter) {
        case 'هذا الشهر':
          return testDate
              .isAfter(currentMonth.subtract(const Duration(days: 1)));
        case 'آخر 3 أشهر':
          return testDate
              .isAfter(threeMonthsAgo.subtract(const Duration(days: 1)));
        case 'هذا العام':
          return testDate
              .isAfter(startOfYear.subtract(const Duration(days: 1)));
        default:
          return true;
      }
    }).toList();
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: customDateRange ??
          DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 30)),
            end: DateTime.now(),
          ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.mainBlue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColor.mainBlueDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        customDateRange = picked;
        selectedFilter = 'فترة مخصصة';
      });
    }
  }

  String _getFilterLabel(String filter) {
    if (filter == 'فترة مخصصة' && customDateRange != null) {
      final startDate = DateFormat('yyyy/MM/dd').format(customDateRange!.start);
      final endDate = DateFormat('yyyy/MM/dd').format(customDateRange!.end);
      return '$startDate - $endDate';
    }
    return filter;
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
          "التحاليل الطبية",
          style: TextStyles.font16DarkBlueW500,
        ),
        backgroundColor: AppColor.white,
      ),
      body: Column(
        children: [
          // فلتر التاريخ
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.sp),
            decoration: BoxDecoration(
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Row(
                children: filters.map((filter) {
                  final isSelected = filter == selectedFilter;
                  return Padding(
                    padding: EdgeInsetsDirectional.only(end: 8.sp),
                    child: FilterChip(
                      selected: isSelected,
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (filter == 'فترة مخصصة' && customDateRange != null)
                            Icon(
                              Icons.calendar_today,
                              size: 14.sp,
                              color: isSelected
                                  ? AppColor.white
                                  : AppColor.mainBlue,
                            ),
                          if (filter == 'فترة مخصصة' && customDateRange != null)
                            4.W,
                          Text(
                            _getFilterLabel(filter),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isSelected
                                  ? AppColor.white
                                  : AppColor.mainBlue,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: AppColor.white,
                      selectedColor: AppColor.mainBlue,
                      checkmarkColor: AppColor.white,
                      side: BorderSide(
                        color: isSelected
                            ? AppColor.mainBlue
                            : AppColor.grey.withOpacity(0.3),
                        width: 1,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          if (filter == 'فترة مخصصة') {
                            _selectDateRange(context);
                          } else {
                            setState(() {
                              selectedFilter = filter;
                              if (filter != 'فترة مخصصة') {
                                customDateRange = null;
                              }
                            });
                          }
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // قائمة التحاليل
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.sp),
              itemCount: filteredLabTests.length,
              itemBuilder: (context, index) {
                final test = filteredLabTests[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 12.sp),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.grey.withValues(alpha: 0.3),
                        // شادو خفيف جدًا
                        spreadRadius: 0.4, // نشر بسيط
                        blurRadius: 4.4, // ضبابية خفيفة
                        offset: Offset(0, 0.4), // ارتفاع بسيط للشادو
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          if (test['status'] == 'مكتمل') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LabTestDetailsScreen(
                                  testData: test,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'النتائج غير متاحة بعد',
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
                        },
                        contentPadding: EdgeInsets.all(12.sp),
                        leading: Container(
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                            color: _getTypeColor(test['type']).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            _getTypeIcon(test['type']),
                            size: 24.sp,
                            color: _getTypeColor(test['type']),
                          ),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                test['name'] ?? '',
                                style: TextStyle(
                                  fontSize: 15.sp,
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
                                color: test['status'] == 'مكتمل'
                                    ? AppColor.green.withOpacity(0.1)
                                    : AppColor.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                test['status'] ?? '',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: test['status'] == 'مكتمل'
                                      ? AppColor.green
                                      : AppColor.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            8.H,
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  size: 14.sp,
                                  color: AppColor.grey,
                                ),
                                4.W,
                                Text(
                                  test['date'] ?? '',
                                  style: TextStyles.font12GreyW400,
                                ),
                                16.W,
                                Icon(
                                  Icons.person_outline,
                                  size: 14.sp,
                                  color: AppColor.grey,
                                ),
                                4.W,
                                Text(
                                  test['doctor'] ?? '',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColor.mainBlue,
                                  ),
                                ),
                              ],
                            ),
                            4.H,
                            Text(
                              test['type'] ?? '',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: _getTypeColor(test['type']),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
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

  IconData _getTypeIcon(String? type) {
    switch (type) {
      case 'تحليل دم':
        return Icons.bloodtype_outlined;
      case 'تحليل بول':
        return Icons.water_drop_outlined;
      case 'تحليل براز':
        return Icons.science_outlined;
      default:
        return Icons.science_outlined;
    }
  }
}
