import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/data.dart';
import 'package:healthy_sync/core/widgets/ui_helpers.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/appointments/cubit/appointments_cubit.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/appointments/cubit/appointments_state.dart';
import 'package:intl/intl.dart';

class AppointmentsScreen extends StatefulWidget {
  //final Patient patient;

  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  DateTime selectedDate = DateTime.now();
  List<String> selectedTimes = [];

  void _selectDate(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'اختر التاريخ',
                style: TextStyles.font16DarkBlueW500,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 300.h,
                child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    final date = DateTime.now().add(Duration(days: index));
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedDate = date;
                          selectedTimes = [];
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[300]!,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('EEEE').format(date),
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy').format(date),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'إلغاء',
                  style: TextStyle(color: AppColor.mainBlue, fontSize: 16.sp),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveAppointments() {
    context
        .read<AppointmentsCubit>()
        .saveAppointments(selectedDate, selectedTimes);
    setState(() {
      selectedTimes = [];
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<AppointmentsCubit>().getAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: Text(
          'المواعيد',
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
      body: RefreshIndicator(
        color: AppColor.mainBlue,
        onRefresh: () async {
          await context.read<AppointmentsCubit>().refreshAppointments();
        },
        child: BlocBuilder<AppointmentsCubit, AppointmentsState>(
          builder: (context, state) {
            if (state is AppointmentsLoading) {
              return showLoading();
            } else if (state is AppointmentsError) {
              return showError(
                message: state.message,
                onRetry: () {
                  context.read<AppointmentsCubit>().getAppointments();
                },
              );
            } else if (state is AppointmentsSuccess) {
              final availableAppointments = state.appointments
                  .where(
                    (appointment) =>
                        appointment.status == AppointmentStatus.scheduled &&
                        appointment.date.year == selectedDate.year &&
                        appointment.date.month == selectedDate.month &&
                        appointment.date.day == selectedDate.day,
                  )
                  .toList();

              return Padding(
                padding: EdgeInsets.all(20.w),
                child: ListView(
                  children: [
                    Text(
                      'المواعيد المتاحة',
                      style: TextStyles.font20WhiteBold
                          .copyWith(color: AppColor.black),
                    ),
                    SizedBox(height: 16.h),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: AppColor.mainBlue,
                                  size: 24.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  DateFormat('dd/MM/yyyy').format(selectedDate),
                                  style: TextStyles.font16DarkBlueW500,
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            if (availableAppointments.isEmpty)
                              Center(
                                child: Text(
                                  'لا توجد مواعيد متاحة',
                                  style: TextStyles.font16DarkBlueW500,
                                ),
                              )
                            else
                              Wrap(
                                spacing: 8.w,
                                runSpacing: 8.h,
                                children:
                                    availableAppointments.map((appointment) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.mainBlue,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      appointment.time,
                                      style: TextStyle(
                                        color: AppColor.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Text(
                      'إضافة مواعيد متاحة',
                      style: TextStyles.font20WhiteBold
                          .copyWith(color: AppColor.black),
                    ),
                    SizedBox(height: 16.h),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => _selectDate(context),
                              child: Container(
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          AppColor.grey.withValues(alpha: 0.3),
                                      spreadRadius: 0.4,
                                      blurRadius: 4.4,
                                      offset: const Offset(0, 0.4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: AppColor.mainBlue,
                                    ),
                                    SizedBox(width: 12.w),
                                    Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(selectedDate),
                                      style: TextStyles.font16DarkBlueW500,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              'اختر المواعيد المتاحة',
                              style: TextStyles.font16DarkBlueW500,
                            ),
                            SizedBox(height: 16.h),
                            Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: availableTimes.map((time) {
                                final isSelected = selectedTimes.contains(time);

                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        selectedTimes.remove(time);
                                      } else {
                                        selectedTimes.add(time);
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColor.mainBlue
                                          : Colors.white,
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColor.mainBlue
                                            : Colors.grey[300]!,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      time,
                                      style: TextStyle(
                                        color: isSelected
                                            ? AppColor.white
                                            : Colors.grey[600],
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            if (selectedTimes.isNotEmpty) ...[
                              SizedBox(height: 24.h),
                              CustomButton(
                                name: 'حفظ المواعيد المتاحة',
                                onTap: () => _saveAppointments(),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
