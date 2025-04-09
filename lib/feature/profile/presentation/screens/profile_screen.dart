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
import 'package:healthy_sync/core/widgets/show_dialog.dart';
import 'package:healthy_sync/feature/profile/presentation/screens/chronic_diseases_screen.dart';
import 'package:healthy_sync/feature/profile/cubit/profile_cubit.dart';
import 'package:healthy_sync/feature/profile/presentation/screens/edit_profile.dart';
import 'package:healthy_sync/feature/profile/presentation/screens/update_password.dart';
import 'package:healthy_sync/feature/welcome/presentation/screens/welcome/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
              SharedHelper.removeKey(SharedKeys.kToken);
              context.pushAndRemoveUntil(const WelcomeScreen());
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
                          color: AppColor.mainBlue.withValues(alpha: .5),
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
                        Gap(16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "يوسف شعبان",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.mainPink,
                                ),
                              ),
                              Text(
                                "البريد الالكتروني",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColor.grey,
                                ),
                              ),
                              Text(
                                "رقم الهاتف",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColor.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.qr_code,
                          color: AppColor.mainPink,
                          size: 24.sp,
                        ),
                      ],
                    ),
                  ),

                  ProfileItem(
                    title: "السن",
                    value: "61",
                    icon: Icons.calendar_today,
                  ),
                  ProfileItem(
                    title: "التخصص",
                    value: "السكري",
                    icon: Icons.medical_services,
                  ),
                  ProfileItem(
                    title: "الامراض المزمنه",
                    onTap: () {
                      context.push(ChronicDiseasesScreen());
                    },
                    icon: Icons.medical_services,
                  ),
                  ProfileItem(
                    title: "هيّا ",
                    icon: Icons.monitor_weight,
                    onTap: () => {},
                  ),
                  ProfileItem(
                    title: "BMI الكتل العضليه",

                    icon: Icons.monitor_weight,
                    onTap: () => {},
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
                      context.pushAndRemoveUntil(const WelcomeScreen());
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
        subtitle:
            value != null
                ? Text(
                  value!,
                  style: TextStyle(fontSize: 14.sp, color: AppColor.grey),
                )
                : null,
        trailing:
            onTap != null
                ? Icon(Icons.arrow_forward_ios, color: AppColor.grey)
                : null,
        onTap: onTap,
      ),
    );
  }
}
