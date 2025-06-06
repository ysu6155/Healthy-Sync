import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/widgets/data.dart';
import 'package:healthy_sync/core/widgets/ui_helpers.dart';
import 'package:healthy_sync/feature/patients/home/data/models/doctor_visit.dart';
import 'package:healthy_sync/feature/patients/home/presentation/specializations/screen/specializations_screen.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/feature/patients/home/presentation/widgets/doctor_visit_card.dart';
import 'package:healthy_sync/feature/patients/home/presentation/widgets/doctors_section.dart';
import 'package:healthy_sync/feature/patients/home/presentation/widgets/specializations.dart';
import 'package:healthy_sync/feature/patients/home/presentation/home/cubit/home_cubit.dart';
import 'package:healthy_sync/feature/patients/home/presentation/home/cubit/home_state.dart';

class HomePatientScreen extends StatelessWidget {
  const HomePatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return Scaffold(body: showLoading());
        }

        if (state is HomeError) {
          return Scaffold(
            body: Center(
              child: Text(
                state.message,
                style: TextStyles.font16DarkBlueW500.copyWith(
                  color: AppColor.red,
                ),
              ),
            ),
          );
        }

        if (state is HomeLoaded) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () => context.read<HomeCubit>().refresh(),
              child: ListView(
                children: [
                  _buildHeader(context, state),
                  16.H,
                  state.isVisitLoading
                      ? buildLoading()
                      : DoctorVisitCard(
                          visit: DoctorVisit(
                            imageUrl: state.visitData?.imageUrl ?? '',
                            id: state.visitData?.id ?? '',
                            rating: state.visitData?.rating ?? 0,
                            experienceYears:
                                state.visitData?.experienceYears ?? 0,
                            phoneNumber: state.visitData?.phoneNumber ?? '',
                            followUpDate: state.visitData?.followUpDate ?? '',
                            doctorName: state.visitData?.doctorName ?? '',
                            specialization:
                                state.visitData?.specialization ?? '',
                            date: state.visitData?.date ?? '',
                            time: state.visitData?.time ?? '',
                            status: state.visitData?.status ?? '',
                            diagnosis: state.visitData?.diagnosis ?? '',
                            symptoms: state.visitData?.symptoms ?? '',
                            treatment: state.visitData?.treatment ?? '',
                            medications: state.visitData?.medications ?? '',
                            recommendations:
                                state.visitData?.recommendations ?? [],
                          ),
                        ).paddingSymmetric(horizontal: 16.w),
                  16.H,
                  _buildSpecializationsHeader(context),
                  8.H,
                  state.isSpecializationsLoading
                      ? buildLoading()
                      : SpecializationsSection(
                          specializations: state.specializations,
                        ),
                  16.H,
                  state.isDoctorsLoading
                      ? buildLoading()
                      : DoctorsSection(
                          doctors: state.doctors,
                        ),
                ],
              ),
            ),
          );
        }

        return const Scaffold(body: SizedBox());
      },
    );
  }

  Widget _buildHeader(
    BuildContext context,
    HomeState state,
  ) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundImage: Image.network(
            profile["image"],
            fit: BoxFit.cover,
          ).image,
        ),
        16.W,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${LocaleKeys.hello.tr()} 👋",
                style: TextStyles.font16DarkBlueW500.copyWith(
                  color: AppColor.black,
                ),
              ),
              Text(
                profile["name"],
                style: TextStyles.font16DarkBlueW500.copyWith(
                  color: AppColor.black,
                ),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 20.r,
          backgroundColor: AppColor.mainBlue,
          child: Icon(
            Icons.language,
            color: AppColor.white,
            size: 20.sp,
          ),
        ).withTapEffect(
          onTap: () {
            log(context.locale.toString());
            if (context.locale.toString() == 'ar') {
              context.setLocale(const Locale('en'));
            } else {
              context.setLocale(const Locale('ar'));
            }
          },
        ),
      ],
    ).paddingAll(16.sp);
  }

  Widget _buildSpecializationsHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            color: AppColor.mainBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.medical_services_outlined,
            color: AppColor.mainBlue,
            size: 20.sp,
          ),
        ),
        12.W,
        Expanded(
          child: Text(
            LocaleKeys.specializations.tr(),
            style: TextStyles.font20WhiteBold.copyWith(
              color: AppColor.mainBlueDark,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (context.read<HomeCubit>().state is HomeLoaded) {
              var specializations =
                  (context.read<HomeCubit>().state as HomeLoaded)
                      .specializations;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpecializationsAll(
                    specializations: specializations,
                  ),
                ),
              );
            }
          },
          child: Text(
            LocaleKeys.seeAll.tr(),
            style: TextStyles.font16DarkBlueW500,
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 16.0.sp);
  }
}
