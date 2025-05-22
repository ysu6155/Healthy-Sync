import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/widgets/ui_helpers.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/patient_details/cubit/patient_details_cubit.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/patient_details/screen/patient_details_screen.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/widgets/card_patient.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/home/cubit/home_cubit.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/home/cubit/home_state.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/qr_scanner/screen/qr_scanner_screen.dart';
import 'package:healthy_sync/feature/doctors/profile/data/rebo/profile_rebo.dart';

class HomeDoctorScreen extends StatefulWidget {
  const HomeDoctorScreen({super.key});

  @override
  State<HomeDoctorScreen> createState() => _HomeDoctorScreenState();
}

class _HomeDoctorScreenState extends State<HomeDoctorScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getPatients();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _scanQR() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => const QRScannerScreen(),
      ),
    );

    if (result != null) {
      _searchController.text = result;
      context.read<HomeCubit>().searchPatients(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: AppColor.mainBlue,
        onRefresh: () async {
          await context.read<HomeCubit>().refreshPatients();
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return showLoading();
            }

            if (state is HomeError) {
              return showError(
                message: state.message,
                onRetry: () {
                  context.read<HomeCubit>().getPatients();
                },
              );
            }

            if (state is HomeLoaded) {
              return ListView(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(700.r),
                          child: CachedNetworkImage(
                            imageUrl: profile['image'] ?? "",
                            width: 60.w,
                            height: 60.h,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[200],
                              child: Icon(Icons.person, size: 50.sp),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
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
                              "${LocaleKeys.doctor.tr()} / ${profile['name']}",
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
                            context.setLocale(Locale('en'));
                          } else {
                            context.setLocale(Locale('ar'));
                          }
                        },
                      ),
                    ],
                  ),
                  16.H,
                  Text(
                    LocaleKeys.findPatient.tr(),
                    style: TextStyles.font20WhiteBold
                        .copyWith(color: AppColor.black),
                  ),
                  16.H,
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.grey.withValues(alpha: 0.3),
                          spreadRadius: 0.4,
                          blurRadius: 4.4,
                          offset: const Offset(0, 0.4),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _searchController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        context.read<HomeCubit>().searchPatients(value);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.sp,
                          vertical: 18.h,
                        ),
                        filled: true,
                        fillColor: AppColor.white,
                        hintStyle: TextStyles.font12GreyW400,
                        border: borderStyle(AppColor.border, 50.r),
                        focusedBorder: borderStyle(AppColor.border, 50.r),
                        enabledBorder: borderStyle(AppColor.transparent, 50.r),
                        errorBorder: borderStyle(AppColor.red, 50.r),
                        focusedErrorBorder: borderStyle(AppColor.red, 50.r),
                        labelStyle: TextStyle(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                        hintText: LocaleKeys.searchHintPatient.tr(),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 25.sp,
                          color: AppColor.black,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: _scanQR,
                          child: Icon(
                            Icons.qr_code,
                            size: 20.sp,
                            color: AppColor.black,
                          ),
                        ),
                        errorStyle: TextStyles.font12BlueW400.copyWith(
                          color: AppColor.red,
                        ),
                      ),
                      style: TextStyles.font12BlueW400.copyWith(
                        fontSize:
                            ResponsiveHelper.isMobile(context) ? 16.sp : 24.sp,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                  16.H,
                  Text(
                    LocaleKeys.patients.tr(),
                    style: TextStyles.font20WhiteBold
                        .copyWith(color: AppColor.black),
                  ),
                  16.H,
                  if (state.filteredPatients.isEmpty)
                    Center(
                      child: Text(
                        'لا توجد مرضي',
                        style: TextStyles.font16DarkBlueW500,
                      ),
                    )
                  else
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: ResponsiveHelper.isMobile(context)
                            ? 2.6.sp
                            : 1.4.sp,
                        mainAxisSpacing: 16.h,
                        crossAxisSpacing: 16.w,
                      ),
                      itemCount: state.filteredPatients.length,
                      itemBuilder: (context, index) {
                        final patient = state.filteredPatients[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => PatientDetailsCubit()
                                    ..getPatientDetails(),
                                  child: PatientDetailsScreen(patient: patient),
                                ),
                              ),
                            );
                          },
                          child: CardPatient(patient: patient),
                        );
                      },
                    ),
                ],
              ).paddingAll(16.sp);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
