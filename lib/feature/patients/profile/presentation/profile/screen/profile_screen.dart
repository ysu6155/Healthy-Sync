
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/ui_helpers.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/bmi/screen/bmi.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/chronic_diseases/screen/chronic_diseases_screen.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/profile/cubit/profile_cubit.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/edit_profile/screen/edit_profile.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/update_password/screen/update_password.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/woman_cycle/cubit/woman_cycle_cubit.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/woman_cycle/screens/woman_cycle_screen.dart';
import 'package:healthy_sync/core/widgets/profile_item.dart';
import 'package:healthy_sync/feature/welcome/presentation/screens/intro/intro_screen.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfilePatientScreen extends StatefulWidget {
  const ProfilePatientScreen({super.key});

  @override
  State<ProfilePatientScreen> createState() => _ProfilePatientScreenState();
}

class _ProfilePatientScreenState extends State<ProfilePatientScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..loadProfile(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 48.sp,
          backgroundColor: AppColor.white,
          title: Text(
            LocaleKeys.profile.tr(),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.black,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: AppColor.black, size: 25.sp),
              onPressed: () {
                SharedHelper.clear();
                context.pushAndRemoveUntil(const IntroScreen());
              },
            ),
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return showLoading();
              }

              if (state is ProfileError) {
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
                          context.read<ProfileCubit>().loadProfile();
                        },
                        child: Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                );
              }

              if (state is ProfileLoaded) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await context.read<ProfileCubit>().refresh();
                  },
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.sp),
                        margin: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  SharedHelper.get(SharedKeys.gender) == "Male"
                                      ? AppColor.mainBlue.withValues(alpha: .5)
                                      : AppColor.mainPink.withValues(alpha: .5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 50.r,
                              backgroundImage:
                                  NetworkImage(state.profile['image'] ?? ""),
                            ),
                            const Gap(16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.profile['name'] ?? "",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.mainPink,
                                    ),
                                  ),
                                  Text(
                                    state.profile['email'] ?? "",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColor.grey,
                                    ),
                                  ),
                                  Text(
                                    state.profile['phone'] ?? "",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColor.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: AppColor.white,
                                      title: Center(
                                        child: Text(
                                          "QR Code",
                                          style: TextStyle(
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      content: Container(
                                        color: Colors.white,
                                        alignment: Alignment.center,
                                        width: 200.sp,
                                        height: 200.sp,
                                        child: QrImageView(
                                          data: state.profile['id'] ?? "",
                                          version: QrVersions.auto,
                                          size: 200.0,
                                        ),
                                      ),
                                      actions: [
                                        CustomButton(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          name: LocaleKeys.cancel.tr(),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Icon(
                                Icons.qr_code,
                                color: AppColor.mainPink,
                                size: 24.sp,
                              ),
                            ),
                          ],
                        ),
                      ),

                      ProfileItem(
                        title: LocaleKeys.age.tr(),
                        value: state.profile['birthDate'] ?? "",
                        icon: Icons.calendar_today,
                      ),

                      ProfileItem(
                        title: "الامراض المزمنه",
                        onTap: () {
                          context.push(ChronicDiseasesScreen());
                        },
                        icon: Icons.medical_services,
                      ),
                      //  if (state.profile['gender'] == "أنثي")
                      ProfileItem(
                        title: "هيّا ",
                        icon: Icons.monitor_weight,
                        onTap: () => {
                          context.push(
                            MultiProvider(
                              providers: [
                                BlocProvider(
                                  create: (_) => WomanCycleCubit(),
                                ),
                              ],
                              child: const WomanCycleScreen(),
                            ),
                          ),
                        },
                      ),
                      // if (SharedHelper.get(SharedKeys.gender) == "male")
                      ProfileItem(
                        title: "BMI الكتل العضليه",
                        icon: Icons.monitor_weight,
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BMICalculatorScreen(),
                            ),
                          )
                        },
                      ),
                      ProfileItem(
                        title: LocaleKeys.editProfile.tr(),
                        icon: Icons.person,
                        onTap: () {
                          context.push(const EditProfile());
                        },
                      ),
                      ProfileItem(
                        title: LocaleKeys.changePassword.tr(),
                        icon: Icons.password,
                        onTap: () {
                          context.push(const UpdatePassword());
                        },
                      ),

                      ProfileItem(
                        title: LocaleKeys.language.tr(),
                        value: LocaleKeys.languageNaw.tr(),
                        icon: Icons.language,
                        onTap: () {
                          setState(() {
                            if (context.locale.toString() == 'ar') {
                              context.setLocale(Locale('en'));
                            } else {
                              context.setLocale(Locale('ar'));
                            }
                          });
                        },
                      ),

                      ProfileItem(
                        title: LocaleKeys.logout.tr(),
                        icon: Icons.logout,
                        onTap: () {
                          SharedHelper.removeKey(SharedKeys.kToken);
                          context.pushAndRemoveUntil(IntroScreen());
                        },
                      ),
                      Gap(15),
                    ],
                  ),
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
