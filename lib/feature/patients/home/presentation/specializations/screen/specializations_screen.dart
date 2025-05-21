import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';
import 'package:healthy_sync/feature/patients/home/presentation/doctors_by_specialty/screen/doctors_by_specialty_screen.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/widgets/shows.dart';
import 'package:healthy_sync/feature/patients/home/presentation/specializations/cubit/specializations_cubit.dart';
import 'package:healthy_sync/feature/patients/home/presentation/specializations/cubit/specializations_state.dart';

class SpecializationsAll extends StatelessWidget {
  const SpecializationsAll({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpecializationsCubit()..loadSpecializations(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 56.sp,
          title: Text(
            LocaleKeys.specializations.tr(),
            style: TextStyle(
              color: const Color(0xFF1E293B),
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
          iconTheme: IconThemeData(
            color: const Color(0xFF1E293B),
            size: 24.sp,
          ),
          backgroundColor: const Color(0xFFF8FAFC),
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocBuilder<SpecializationsCubit, SpecializationsState>(
          builder: (context, state) {
            if (state is SpecializationsLoading) {
              return showLoading();
            }

            if (state is SpecializationsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: TextStyle(
                        color: const Color(0xFF1E293B),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<SpecializationsCubit>()
                            .loadSpecializations();
                      },
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            if (state is SpecializationsLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // قسم البحث
                  Container(
                    margin: EdgeInsets.fromLTRB(16.sp, 16.sp, 16.sp, 12.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.mainBlue.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // حقل البحث
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.sp, vertical: 12.sp),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: Colors.grey[200]!,
                              width: 1.w,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.sp),
                                decoration: BoxDecoration(
                                  color: AppColor.mainBlue.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.search_rounded,
                                  color: AppColor.mainBlue,
                                  size: 20.sp,
                                ),
                              ),
                              12.W,
                              Expanded(
                                child: CustomTextField(
                                  hintText: "ابحث عن تخصص طبي...",
                                  hintTextStyle: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  onChanged: (value) {
                                    context
                                        .read<SpecializationsCubit>()
                                        .searchSpecializations(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // قائمة التخصصات
                  Expanded(
                    child: state.specializations.isEmpty
                        ? Center(
                            child: Text(
                              "لا توجد تخصصات متاحة",
                              style: TextStyle(
                                color: const Color(0xFF1E293B),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : GridView.builder(
                            padding: EdgeInsets.all(16.sp),
                            itemCount: state.specializations.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.w,
                              mainAxisSpacing: 16.h,
                              childAspectRatio: 0.85,
                            ),
                            itemBuilder: (context, index) {
                              final specialty = state.specializations[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DoctorsBySpecialtyScreen(
                                        selectedSpecialty: specialty,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        const Color(0xFFF8FAFC),
                                        const Color(0xFFF1F5F9),
                                        const Color(0xFFE2E8F0),
                                      ],
                                      stops: const [0.0, 0.5, 1.0],
                                    ),
                                    borderRadius: BorderRadius.circular(20.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFCBD5E0)
                                            .withOpacity(0.3),
                                        blurRadius: 15,
                                        offset: const Offset(0, 8),
                                        spreadRadius: 2,
                                      ),
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      // عناصر زخرفية محسنة
                                      Positioned(
                                        right: -20.w,
                                        top: -20.h,
                                        child: Container(
                                          width: 100.w,
                                          height: 100.h,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: RadialGradient(
                                              colors: [
                                                const Color(0xFFE2E8F0)
                                                    .withOpacity(0.4),
                                                const Color(0xFFE2E8F0)
                                                    .withOpacity(0.1),
                                              ],
                                              stops: const [0.3, 1.0],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: -15.w,
                                        bottom: -15.h,
                                        child: Container(
                                          width: 80.w,
                                          height: 80.h,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: RadialGradient(
                                              colors: [
                                                const Color(0xFFE2E8F0)
                                                    .withOpacity(0.4),
                                                const Color(0xFFE2E8F0)
                                                    .withOpacity(0.1),
                                              ],
                                              stops: const [0.3, 1.0],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // محتوى البطاقة
                                      Padding(
                                        padding: EdgeInsets.all(16.sp),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(16.sp),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    const Color(0xFFE2E8F0)
                                                        .withOpacity(0.6),
                                                    const Color(0xFFE2E8F0)
                                                        .withOpacity(0.4),
                                                  ],
                                                ),
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: AppColor.mainBlue
                                                      .withOpacity(0.6),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Icon(
                                                specialty['icon'] as IconData,
                                                size: 32.sp,
                                                color: AppColor.mainBlue,
                                              ),
                                            ),
                                            SizedBox(height: 12.h),
                                            Text(
                                              specialty['name'] as String,
                                              style: TextStyle(
                                                color: const Color(0xFF1E293B),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.1,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
