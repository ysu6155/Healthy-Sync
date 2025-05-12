import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/feature/doctors/home/data/prescription_data.dart';
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';
import 'package:intl/intl.dart';

class PrescriptionsListScreen extends StatelessWidget {
  final Patient patient;

  const PrescriptionsListScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final patientPrescriptions = prescriptions
        .where((prescription) => prescription.patientId == patient.id)
        .toList();

    return Scaffold(
      //backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: Text(
          'الروشتات السابقة',
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
      body: patientPrescriptions.isEmpty
          ? Center(
              child: Text(
                'لا توجد روشتات سابقة',
                style: TextStyles.font16DarkBlueW500,
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: patientPrescriptions.length,
              itemBuilder: (context, index) {
                final prescription = patientPrescriptions[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16.h),
                  child: InkWell(
                    onTap: () {
                      // TODO: Navigate to prescription details
                    },
                    borderRadius: BorderRadius.circular(15.r),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.medical_services,
                                color: AppColor.mainBlue,
                                size: 24.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'روشته ${index + 1}',
                                style: TextStyles.font16DarkBlueW500,
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.grey,
                                size: 18.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                DateFormat(
                                  'dd/MM/yyyy',
                                ).format(prescription.date ?? DateTime.now()),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'الأعراض:',
                            style: TextStyles.font16DarkBlueW500,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            prescription.symptoms ?? '',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (prescription.requiredTests?.isNotEmpty ??
                              false) ...[
                            SizedBox(height: 8.h),
                            Text(
                              'التحاليل المطلوبة:',
                              style: TextStyles.font16DarkBlueW500,
                            ),
                            SizedBox(height: 4.h),
                            ...(prescription.requiredTests ?? []).map((test) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 4.h),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.science,
                                      color: Colors.grey,
                                      size: 16.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Text(
                                        test,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                          SizedBox(height: 8.h),
                          Text(
                            'الأدوية:',
                            style: TextStyles.font16DarkBlueW500,
                          ),
                          SizedBox(height: 4.h),
                          ...(prescription.medications ?? []).map((
                            medication,
                          ) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.medication,
                                    color: Colors.grey,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      '${medication.name} - ${medication.dosage}',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          if (prescription.notes?.isNotEmpty ?? false) ...[
                            SizedBox(height: 8.h),
                            Text(
                              'ملاحظات:',
                              style: TextStyles.font16DarkBlueW500,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              prescription.notes ?? '',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
