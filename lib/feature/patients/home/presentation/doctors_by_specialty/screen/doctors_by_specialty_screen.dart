import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/widgets/ui_helpers.dart';
import 'package:healthy_sync/feature/patients/home/presentation/doctor_details/screen/doctor_details.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/feature/patients/home/presentation/widgets/card_doctor.dart';
import 'package:healthy_sync/feature/patients/home/presentation/doctors_by_specialty/cubit/doctors_by_specialty_cubit.dart';
import 'package:healthy_sync/feature/patients/home/presentation/doctors_by_specialty/cubit/doctors_by_specialty_state.dart';

class DoctorsBySpecialtyScreen extends StatelessWidget {
  final Map selectedSpecialty;

  const DoctorsBySpecialtyScreen({super.key, required this.selectedSpecialty});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorsBySpecialtyCubit()
        ..loadDoctorsBySpecialty(selectedSpecialty["value"]),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 48.sp,
          title: Row(
            children: [
              Text(
                "${selectedSpecialty["name"]}",
                style: TextStyles.font20WhiteBold,
              ),
              8.W,
              Icon(selectedSpecialty["icon"], size: 24.sp),
            ],
          ),
          iconTheme: IconThemeData(color: AppColor.white, size: 16.sp),
          backgroundColor: AppColor.mainBlue,
        ),
        body: BlocBuilder<DoctorsBySpecialtyCubit, DoctorsBySpecialtyState>(
          builder: (context, state) {
            if (state is DoctorsBySpecialtyLoading) {
              return showLoading();
            }

            if (state is DoctorsBySpecialtyError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: TextStyles.font16DarkBlueW500,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<DoctorsBySpecialtyCubit>()
                            .loadDoctorsBySpecialty(selectedSpecialty["value"]);
                      },
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            if (state is DoctorsBySpecialtyLoaded) {
              if (state.doctors.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<DoctorsBySpecialtyCubit>()
                        .loadDoctorsBySpecialty(selectedSpecialty["value"]);
                  },
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.sp,
                        vertical: 16.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColor.mainBlue,
                        ),
                      ),
                      child: Text(
                        "لا يوجد أطباء لهذا التخصص",
                        style: TextStyles.font16DarkBlueW500,
                      ),
                    ),
                  ),
                );
              }

              return GridView.builder(
                itemCount: state.doctors.length,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.sp,
                  vertical: 16.w,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.sp,
                  childAspectRatio:
                      ResponsiveHelper.isMobile(context) ? 3.1.sp : 1.6.sp,
                ),
                itemBuilder: (context, index) {
                  final doctor = state.doctors[index];
                  return CardDoctor(doctor: doctor, index: index).withTapEffect(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorDetails(
                            doctorId: doctor['id'].toString(),
                          ),
                        ),
                      );
                    },
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
