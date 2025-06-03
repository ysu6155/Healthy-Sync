import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/widgets/ui_helpers.dart';
import 'package:healthy_sync/feature/patients/treatment_schedule/presentation/cubit/treatment_schedule_cubit.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';

class TreatmentScheduleScreen extends StatelessWidget {
  const TreatmentScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TreatmentScheduleCubit()..loadSchedules(),
      child: const _TreatmentScheduleView(),
    );
  }
}

class _TreatmentScheduleView extends StatefulWidget {
  const _TreatmentScheduleView();

  @override
  State<_TreatmentScheduleView> createState() => _TreatmentScheduleViewState();
}

class _TreatmentScheduleViewState extends State<_TreatmentScheduleView> {
  final DateTime _selectedDate = DateTime.now();
  int _currentTabIndex = 0;

  void _confirmMedication(String id) {
    context.read<TreatmentScheduleCubit>().markAsCompleted(id);
  }

  void _confirmTest(String id) {
    context.read<TreatmentScheduleCubit>().markAsCompleted(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        toolbarHeight: 48.sp,
        backgroundColor: AppColor.white,
        title: Text(
          LocaleKeys.treatmentSchedule.tr(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<TreatmentScheduleCubit, TreatmentScheduleState>(
        builder: (context, state) {
          if (state is TreatmentScheduleLoading) {
            return showLoading();
          }

          if (state is TreatmentScheduleError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: TextStyle(color: Colors.red, fontSize: 16.sp),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TreatmentScheduleCubit>().loadSchedules();
                    },
                    child: Text(LocaleKeys.retry.tr()),
                  ),
                ],
              ),
            );
          }

          if (state is TreatmentScheduleLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<TreatmentScheduleCubit>().refresh();
              },
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.all(16.sp),
                    padding: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      color: AppColor.mainBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border:
                          Border.all(color: AppColor.mainBlue.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('EEEE').format(_selectedDate),
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              DateFormat('d MMMM yyyy').format(_selectedDate),
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
                                color: _currentTabIndex == 0
                                    ? AppColor.mainBlue
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: Text(
                                  LocaleKeys.medications.tr(),
                                  style: TextStyle(
                                    color: _currentTabIndex == 0
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
                                color: _currentTabIndex == 1
                                    ? AppColor.mainBlue
                                    : Colors.grey[300],
                              ),
                              child: Center(
                                child: Text(
                                  LocaleKeys.tests.tr(),
                                  style: TextStyle(
                                    color: _currentTabIndex == 1
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
                    child: _currentTabIndex == 0
                        ? _buildMedicationsList(state.schedules)
                        : _buildTestsList(state.schedules),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildMedicationsList(List<Map<String, dynamic>> schedules) {
    final medications =
        schedules.where((s) => s['type'] == 'medication').toList();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      itemCount: medications.length,
      itemBuilder: (context, index) {
        final med = medications[index];
        return _MedicationCard(
          medication: med,
          onConfirm: () => _confirmMedication(med['id']),
        );
      },
    );
  }

  Widget _buildTestsList(List<Map<String, dynamic>> schedules) {
    final tests = schedules.where((s) => s['type'] == 'test').toList();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      itemCount: tests.length,
      itemBuilder: (context, index) {
        final test = tests[index];
        return _TestCard(test: test, onConfirm: () => _confirmTest(test['id']));
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
                          tr(LocaleKeys.takenAt),
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          DateFormat('HH:mm').format(medication['lastTaken']),
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    ),
                  )
                else
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.confirmIntake.tr(),
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
                  child: medication['medicationType'] == tr(LocaleKeys.pills)
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
                  '${medication['remaining']} ${LocaleKeys.remaining.tr()}',
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
                        LocaleKeys.confirmTest.tr(),
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
              '${LocaleKeys.testDate.tr()}: ${test['date']}',
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
