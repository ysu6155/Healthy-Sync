import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/core/widgets/ui_helpers.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/prescriptions_list/cubit/prescriptions_list_cubit.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/prescriptions_list/cubit/prescriptions_list_state.dart';

class PrescriptionsListScreen extends StatefulWidget {
  final Patient patient;

  const PrescriptionsListScreen({
    super.key,
    required this.patient,
  });

  @override
  State<PrescriptionsListScreen> createState() =>
      _PrescriptionsListScreenState();
}

class _PrescriptionsListScreenState extends State<PrescriptionsListScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<PrescriptionsListCubit>()
        .getPrescriptions(patient: widget.patient);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: Text(
          'روشتات ${widget.patient.name}',
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
          context
              .read<PrescriptionsListCubit>()
              .getPrescriptions(patient: widget.patient);
        },
        child: BlocBuilder<PrescriptionsListCubit, PrescriptionsListState>(
          builder: (context, state) {
            if (state is PrescriptionsListLoading) {
              return showLoading();
            } else if (state is PrescriptionsListError) {
              return showError(
                message: state.message,
                onRetry: () {
                  context
                      .read<PrescriptionsListCubit>()
                      .getPrescriptions(patient: widget.patient);
                },
              );
            } else if (state is PrescriptionsListSuccess) {
              if (state.prescriptions.isEmpty) {
                return Center(
                  child: Text(
                    'لا توجد روشتات',
                    style: TextStyles.font16DarkBlueW500,
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: state.prescriptions.length,
                itemBuilder: (context, index) {
                  final prescription = state.prescriptions[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 16.h),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'روشته ${index + 1}',
                                style: TextStyles.font16DarkBlueW500,
                              ),
                              const Spacer(),
                              Text(
                                DateFormat('dd/MM/yyyy').format(
                                    prescription.date ?? DateTime.now()),
                                style: TextStyles.font12GreyW400,
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'الأعراض:',
                            style: TextStyles.font14DarkBlueW500,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            prescription.symptoms ?? '',
                            style: TextStyles.font12GreyW400,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'الأدوية:',
                            style: TextStyles.font14DarkBlueW500,
                          ),
                          SizedBox(height: 4.h),
                          ...(prescription.medications ?? []).map((medication) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: Text(
                                '${medication.name} - ${medication.dosage} - ${medication.duration}',
                                style: TextStyles.font12GreyW400,
                              ),
                            );
                          }).toList(),
                          if ((prescription.requiredTests ?? [])
                              .isNotEmpty) ...[
                            SizedBox(height: 12.h),
                            Text(
                              'التحاليل المطلوبة:',
                              style: TextStyles.font14DarkBlueW500,
                            ),
                            SizedBox(height: 4.h),
                            ...(prescription.requiredTests ?? []).map((test) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 4.h),
                                child: Text(
                                  test,
                                  style: TextStyles.font12GreyW400,
                                ),
                              );
                            }).toList(),
                          ],
                          if ((prescription.notes ?? '').isNotEmpty) ...[
                            SizedBox(height: 12.h),
                            Text(
                              'ملاحظات:',
                              style: TextStyles.font14DarkBlueW500,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              prescription.notes ?? '',
                              style: TextStyles.font12GreyW400,
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
