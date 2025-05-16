import 'dart:developer';

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
import 'package:healthy_sync/core/widgets/show_dialog.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/screens/bmi.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/screens/chronic_diseases_screen.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/cubit/profile_cubit.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/screens/edit_profile.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/screens/update_password.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/screens/woman_cycle_screen.dart';
import 'package:healthy_sync/feature/welcome/presentation/screens/intro/intro_screen.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileDoctorScreen extends StatefulWidget {
  const ProfileDoctorScreen({super.key});

  @override
  State<ProfileDoctorScreen> createState() => _ProfileDoctorScreenState();
}

class _ProfileDoctorScreenState extends State<ProfileDoctorScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return showLoading();
            } else if (state is ProfileError) {
              log(SharedHelper.get(SharedKeys.gender).toString());
              return ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.sp),
                    margin: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: SharedHelper.get(SharedKeys.gender) == "male"
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
                          // backgroundImage: NetworkImage(state.image ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                SharedHelper.get(SharedKeys.name) ?? "Name",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.mainPink,
                                ),
                              ),
                              Text(
                                SharedHelper.get(SharedKeys.email) ?? "Email",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColor.grey,
                                ),
                              ),
                              Text(
                                SharedHelper.get(SharedKeys.phone) ?? "Phone",
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
                                    width: 200.sp, // حددت العرض
                                    height: 200.sp, // حددت الارتفاع
                                    child: QrImageView(
                                      data: SharedHelper.get(
                                        SharedKeys.id,
                                      ).toString(),
                                      version: QrVersions.auto,
                                      size: 200.0,
                                    ),
                                  ),
                                  actions: [
                                    CustomButton(
                                      onTap: () {
                                        Navigator.of(
                                          context,
                                        ).pop(); // بص يا جو، دي هتقفل الـ dialog
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
                    value: SharedHelper.get(SharedKeys.dateOfBirth).toString(),
                    icon: Icons.calendar_today,
                  ),
                  // if (SharedHelper.get(SharedKeys.role) == "doctor")
                  ProfileItem(
                    title: LocaleKeys.specialization.tr(),
                    value: "السكري",
                    icon: Icons.medical_services,
                  ),
                  // if (SharedHelper.get(SharedKeys.role) == "patient")
                  ProfileItem(
                    title: "الامراض المزمنه",
                    onTap: () {
                      context.push(ChronicDiseasesScreen());
                    },
                    icon: Icons.medical_services,
                  ),
                  //  if (SharedHelper.get(SharedKeys.gender) == "female")
                  ProfileItem(
                    title: "هيّا ",
                    icon: Icons.monitor_weight,
                    onTap: () => {
                      context.push(
                        MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                              create: (_) => CycleProvider(),
                            ),
                          ],
                          child: WomanCycleScreen(),
                        ),
                      ),
                    },
                  ),
                  // if (SharedHelper.get(SharedKeys.gender) == "male")
                  ProfileItem(
                    title: "BMI الكتل العضليه",
                    icon: Icons.monitor_weight,
                    onTap: () => {context.push(BMICalculatorScreen())},
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
              );
            }
            return Center(
              child: Text(
                "Failed to load profile",
                style: TextStyle(color: AppColor.red, fontSize: 18.sp),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String title;
  final String? value;
  final IconData icon;
  final VoidCallback? onTap;

  const ProfileItem({
    required this.title,
    this.value,
    required this.icon,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 6.sp),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        leading: Icon(icon, color: AppColor.mainPink, size: 30.sp),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.black,
          ),
        ),
        subtitle: value != null
            ? Text(
                value!,
                style: TextStyle(fontSize: 14.sp, color: AppColor.grey),
              )
            : null,
        trailing: onTap != null
            ? Icon(Icons.arrow_forward_ios, color: AppColor.grey)
            : null,
        onTap: onTap,
      ),
    );
  }
}
