import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/feature/doctors/home/data/appointment_data.dart';
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';
import 'package:intl/intl.dart';

class BookedAppointmentsScreen extends StatelessWidget {
  const BookedAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookedAppointments =
        appointments
            .where((appointment) => appointment.status == 'booked')
            .toList();

    // Group appointments by date
    final Map<DateTime, List<Appointment>> appointmentsByDate = {};
    for (var appointment in bookedAppointments) {
      if (appointment.date != null) {
        final date = DateTime(
          appointment.date!.year,
          appointment.date!.month,
          appointment.date!.day,
        );
        if (!appointmentsByDate.containsKey(date)) {
          appointmentsByDate[date] = [];
        }
        appointmentsByDate[date]!.add(appointment);
      }
    }

    // Sort dates
    final sortedDates =
        appointmentsByDate.keys.toList()..sort((a, b) => a.compareTo(b));

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: Text(
          'المواعيد المحجوزة',
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
      body:
          bookedAppointments.isEmpty
              ? Center(
                child: Text(
                  'لا توجد مواعيد محجوزة',
                  style: TextStyles.font16DarkBlueW500,
                ),
              )
              : ListView.builder(
                padding: EdgeInsets.all(20.w),
                itemCount: sortedDates.length,
                itemBuilder: (context, index) {
                  final date = sortedDates[index];
                  final dateAppointments = appointmentsByDate[date]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('EEEE, dd/MM/yyyy').format(date),
                        style: TextStyles.font16DarkBlueW500,
                      ),
                      SizedBox(height: 16.h),
                      ...dateAppointments.map((appointment) {
                        // Find patient by ID
                        final patient = patients.firstWhere(
                          (p) => p.id == appointment.patientId,
                          orElse:
                              () => Patient(
                                id: appointment.patientId,
                                name: 'مريض',
                                age: 0,
                                phone: '',
                                email: '',
                                address: '',
                              ),
                        );

                        return Card(
                          margin: EdgeInsets.only(bottom: 16.h),
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25.r,
                                      backgroundColor: Colors.grey[200],
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.grey[600],
                                        size: 30.sp,
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            patient.name ?? 'مريض',
                                            style:
                                                TextStyles.font16DarkBlueW500,
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            '${patient.age} سنة',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: AppColor.mainBlue,
                                      size: 24.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      appointment.time ?? '',
                                      style: TextStyles.font16DarkBlueW500,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.medical_services,
                                      color: Colors.grey,
                                      size: 18.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      appointment.type ?? '',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                if (appointment.notes?.isNotEmpty ?? false) ...[
                                  SizedBox(height: 8.h),
                                  Text(
                                    appointment.notes ?? '',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                      SizedBox(height: 24.h),
                    ],
                  );
                },
              ),
    );
  }
}
