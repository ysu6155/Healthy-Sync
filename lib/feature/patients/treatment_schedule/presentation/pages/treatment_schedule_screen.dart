import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/widgets/show_dialog.dart';

class TreatmentScheduleScreen extends StatefulWidget {
  const TreatmentScheduleScreen({super.key});

  @override
  State<TreatmentScheduleScreen> createState() =>
      _TreatmentScheduleScreenState();
}

class _TreatmentScheduleScreenState extends State<TreatmentScheduleScreen> {
  List<Map<String, dynamic>> medications = [
    {
      'name': '25 وحدة السولين',
      'time': '09:00',
      'taken': false,
      'remaining': 10,
      'lastTaken': null,
      'type': 'حقنة',
    },
    {
      'name': 'برندوبريل 10 مع',
      'time': '19:00',
      'taken': false,
      'remaining': 10,
      'lastTaken': null,
      'type': 'حبوب',
    },
    {
      'name': 'املودويني 5 مع',
      'time': '19:00',
      'taken': true,
      'remaining': 10,
      'lastTaken': DateTime.now(),
      'type': 'حبوب',
    },
    {
      'name': 'فوروسيميد 20 مع',
      'time': '19:00',
      'taken': false,
      'remaining': 10,
      'lastTaken': null,
      'type': 'حبوب',
    },
    {
      'name': 'اسبرين 81 مع',
      'time': '19:00',
      'taken': false,
      'remaining': 10,
      'lastTaken': null,
      'type': 'حبوب',
    },
  ];

  List<Map<String, dynamic>> tests = [
    {'name': 'تحليل سكر تراكمي', 'date': '2023-12-15', 'done': false},
    {'name': 'تحليل وظائف كبد', 'date': '2023-12-20', 'done': true},
    {'name': 'تحليل وظائف كلى', 'date': '2023-12-25', 'done': false},
    {'name': 'تحليل دهون ثلاثية', 'date': '2023-12-30', 'done': true},
    {'name': 'تحليل كوليسترول', 'date': '2023-12-31', 'done': false},
    {'name': 'تحليل فيتامين د', 'date': '2023-12-31', 'done': false},
    {'name': 'تحليل فيتامين ب12', 'date': '2023-12-31', 'done': false},
    {'name': 'تحليل CBC', 'date': '2023-12-31', 'done': false},
    {'name': 'تحليل CRP', 'date': '2023-12-31', 'done': false},
  ];

  final DateTime _selectedDate = DateTime.now();
  int _currentTabIndex = 0;

  void _confirmMedication(int index) {
    setState(() {
      medications = List.from(medications); // اعمل نسخة جديدة
      medications[index]['taken'] = true;
      medications[index]['lastTaken'] = DateTime.now();
      medications[index]['remaining']--;
    });

    showSuccessSnackBar(
      'تم تأكيد تناول ${medications[index]['name']}',
      context,
    );
  }

  void _confirmTest(int index) {
    setState(() {
      tests[index]['done'] = true;
    });
    showSuccessSnackBar('تم تأكيد إجراء ${tests[index]['name']}', context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,

      appBar: AppBar(
        toolbarHeight: 48.sp,
        backgroundColor: AppColor.white,
        title: Text(
          'الجدول العلاجي',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(16.sp),
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: AppColor.mainBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColor.mainBlue.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEEE', 'ar').format(_selectedDate),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      DateFormat('d MMMM yyyy', 'ar').format(_selectedDate),
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
                Icon(
                  Icons.calendar_today,
                  color: AppColor.mainBlue,
                  size: 24.sp,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _currentTabIndex = 0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 16.w,
                      ),
                      decoration: BoxDecoration(
                        color:
                            _currentTabIndex == 0
                                ? AppColor.mainBlue
                                : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.r),
                      ),

                      child: Center(
                        child: Text(
                          'الأدوية',
                          style: TextStyle(
                            color:
                                _currentTabIndex == 0
                                    ? AppColor.white
                                    : AppColor.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _currentTabIndex = 1),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 16.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color:
                            _currentTabIndex == 1
                                ? AppColor.mainBlue
                                : Colors.grey[300],
                      ),

                      child: Center(
                        child: Text(
                          'التحاليل',
                          style: TextStyle(
                            color:
                                _currentTabIndex == 1
                                    ? AppColor.white
                                    : AppColor.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child:
                _currentTabIndex == 0
                    ? _buildMedicationsList()
                    : _buildTestsList(),
          ),

          /// SizedBox(height: 60.h),
        ],
      ),
    );
  }

  Widget _buildMedicationsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      itemCount: medications.length,
      itemBuilder: (context, index) {
        final med = medications[index];
        return _MedicationCard(
          medication: med,
          onConfirm: () => _confirmMedication(index),
        );
      },
    );
  }

  Widget _buildTestsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      itemCount: tests.length,
      itemBuilder: (context, index) {
        final test = tests[index];
        return _TestCard(test: test, onConfirm: () => _confirmTest(index));
      },
    );
  }
}

class _MedicationCard extends StatelessWidget {
  final Map<String, dynamic> medication;
  final VoidCallback onConfirm;

  const _MedicationCard({required this.medication, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Expanded(
                  flex: 10,
                  child: Text(
                    medication['name'],
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.black,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                if (medication['taken'])
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 7.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: AppColor.green,
                          size: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'تم التناول في ${DateFormat('HH:mm').format(medication['lastTaken'])}',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Text(
                        "تاكيد التناول",
                        style: TextStyle(
                          color: AppColor.mainPink,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),

                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.check_circle,
                              color: AppColor.green,
                              size: 24.sp,
                            ),
                            onPressed: onConfirm,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.red,
                              size: 24.sp,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColor.mainBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child:
                      medication['type'] == "حبوب"
                          ? SvgPicture.asset(
                            AppAssets.pillsSvg,
                            height: 20.sp,
                            width: 20.sp,
                            colorFilter: ColorFilter.mode(
                              AppColor.mainBlueDark,
                              BlendMode.srcIn,
                            ),
                          )
                          : SvgPicture.asset(
                            AppAssets.injectionSvg,
                            height: 20.sp,
                            width: 20.sp,
                            colorFilter: ColorFilter.mode(
                              AppColor.mainBlueDark,
                              BlendMode.srcIn,
                            ),
                          ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                _buildInfoItem(Icons.access_time, medication['time']),
                SizedBox(width: 16.w),
                _buildInfoItem(
                  Icons.medication,
                  '${medication['remaining']} متبقية',
                ),
              ],
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: Colors.grey[600]),
        SizedBox(width: 4.w),
        Text(text, style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }
}

class _TestCard extends StatelessWidget {
  final Map<String, dynamic> test;
  final VoidCallback onConfirm;

  const _TestCard({required this.test, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 10,
                  child: Text(
                    test['name'],
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (!test['done'])
                  Column(
                    children: [
                      Text(
                        'تأكيد التحليل',
                        style: TextStyle(
                          color: AppColor.mainPink,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.check_circle,
                              color: AppColor.green,
                              size: 24.sp,
                            ),
                            onPressed: onConfirm,
                          ),
                          SizedBox(width: 4.w),
                          IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.red,
                              size: 24.sp,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  Icon(Icons.check, color: Colors.green, size: 24.sp),
              ],
            ),
            SizedBox(height: 12.h),
            _buildInfoItem(
              Icons.calendar_today,
              'موعد التحليل: ${test['date']}',
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: Colors.grey[600]),
        SizedBox(width: 8.w),
        Expanded(child: Text(text, style: TextStyle(fontSize: 12.sp))),
      ],
    );
  }
}
