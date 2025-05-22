import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/widgets/ui_helpers.dart';
import 'package:healthy_sync/feature/doctors/home/data/appointment_data.dart';
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/booked_appointments/cubit/booked_appointments_cubit.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/booked_appointments/cubit/booked_appointments_state.dart';
import 'package:healthy_sync/feature/doctors/profile/data/rebo/profile_rebo.dart';
import 'package:intl/intl.dart';

class BookedAppointmentsScreen extends StatelessWidget {
  const BookedAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookedAppointmentsCubit()..getBookedAppointments(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          toolbarHeight: 60.h,
          title: Text(
            LocaleKeys.bookedAppointments.tr(),
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
            await context
                .read<BookedAppointmentsCubit>()
                .refreshBookedAppointments();
          },
          child: BlocBuilder<BookedAppointmentsCubit, BookedAppointmentsState>(
            builder: (context, state) {
              if (state is BookedAppointmentsLoading) {
                return showLoading();
              } else if (state is BookedAppointmentsError) {
                return showError(
                  message: state.message,
                  onRetry: () {
                    context
                        .read<BookedAppointmentsCubit>()
                        .getBookedAppointments();
                  },
                );
              } else if (state is BookedAppointmentsSuccess) {
                if (state.appointments.isEmpty) {
                  return Center(
                    child: Text(
                      LocaleKeys.noBookedAppointments.tr(),
                      style: TextStyles.font16DarkBlueW500,
                    ),
                  );
                }

                // Group appointments by date
                final Map<DateTime, List<Appointment>> appointmentsByDate = {};
                for (var appointment in state.appointments) {
                  final date = DateTime(
                    appointment.date.year,
                    appointment.date.month,
                    appointment.date.day,
                  );
                  if (!appointmentsByDate.containsKey(date)) {
                    appointmentsByDate[date] = [];
                  }
                  appointmentsByDate[date]!.add(appointment);
                }

                // Sort dates
                final sortedDates = appointmentsByDate.keys.toList()
                  ..sort((a, b) => a.compareTo(b));

                return ListView.builder(
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
                            orElse: () => Patient(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              spreadRadius: 0.4,
                                              blurRadius: 4.4,
                                              offset: const Offset(0, 0.4),
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          radius: 50.r,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(700.r),
                                            child: CachedNetworkImage(
                                              imageUrl: patient.image ?? "",
                                              width: 100.w,
                                              height: 100.h,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Container(
                                                color: Colors.grey[200],
                                                child: Icon(Icons.person,
                                                    size: 50.sp),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              patient.name ??
                                                  LocaleKeys.patient.tr(),
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              '${patient.age} ${LocaleKeys.years.tr()}',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: AppColor.mainBlue,
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.phone,
                                                  color: Colors.grey,
                                                  size: 18.sp,
                                                ),
                                                SizedBox(width: 5.w),
                                                Text(
                                                  patient.phone ?? '',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5.h),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.email,
                                                  color: Colors.grey,
                                                  size: 18.sp,
                                                ),
                                                SizedBox(width: 5.w),
                                                Expanded(
                                                  child: Text(
                                                    patient.email ?? '',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  Text(
                                    '${LocaleKeys.address.tr()}: ${patient.address}',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey[700],
                                      height: 1.5,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  Container(
                                    padding: EdgeInsets.all(15.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey[300]!,
                                      ),
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              color: AppColor.mainBlue,
                                              size: 24.sp,
                                            ),
                                            SizedBox(width: 10.w),
                                            Text(
                                              LocaleKeys.appointmentTime.tr(),
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          appointment.time,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.medical_services,
                                              color: AppColor.mainBlue,
                                              size: 24.sp,
                                            ),
                                            SizedBox(width: 10.w),
                                            Text(
                                              LocaleKeys.visitType.tr(),
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          appointment.type ?? '',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        if (appointment.notes?.isNotEmpty ??
                                            false) ...[
                                          SizedBox(height: 10.h),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.note,
                                                color: AppColor.mainBlue,
                                                size: 24.sp,
                                              ),
                                              SizedBox(width: 10.w),
                                              Text(
                                                'ملاحظات',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5.h),
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
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        SizedBox(height: 24.h),
                      ],
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
