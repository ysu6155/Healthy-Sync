import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
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
        backgroundColor: AppColor.main,
        title: Text(
          LocaleKeys.profile.tr(),
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: AppColor.white),
            onPressed: () {
              SharedHelper.removeKey(SharedKeys.kToken);
              context.pushAndRemoveUntil(const WelcomeScreen());
            },
          ),
        ],
      ),
      body: SafeArea(
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
              return Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              return ListView(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: NetworkImage(state.image),
                      ),
                      16.W,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.name,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColor.main,
                            ),
                          ),
                          Text(state.email),
                        ],
                      ),
                    ],
                  ).paddingAll(16.sp),

                  ProfileItem(
                    title: LocaleKeys.phone.tr(),
                    value: state.phone,
                    icon: Icons.phone,
                  ),
                  ProfileItem(
                    title: LocaleKeys.address.tr(),
                    value: state.address,
                    icon: Icons.location_on,
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
            return Center(child: Text("Failed to load profile"));
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
            color: Colors.black.withValues(
              alpha: 1,
              blue: .8,
              green: .5,
              red: .2,
            ),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColor.main),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: value != null ? Text(value!) : null,
        trailing:
            onTap != null
                ? Icon(Icons.arrow_forward_ios, color: Colors.grey)
                : null,
        onTap: onTap,
      ),
    );
  }
}
