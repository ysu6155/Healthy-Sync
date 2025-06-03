import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:healthy_sync/core/widgets/ui_helpers.dart';
import 'package:healthy_sync/core/widgets/profile_item.dart';
import 'package:healthy_sync/feature/lab/profile/presentation/profile/cubit/profile_cubit.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/edit_profile/screen/edit_profile.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/update_password/screen/update_password.dart';
import 'package:healthy_sync/feature/welcome/presentation/screens/intro/intro_screen.dart';

class ProfileLabScreen extends StatefulWidget {
  const ProfileLabScreen({super.key});

  @override
  State<ProfileLabScreen> createState() => _ProfileLabScreenState();
}

class _ProfileLabScreenState extends State<ProfileLabScreen> {
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
                              radius: 40.r,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(700.r),
                                child: CachedNetworkImage(
                                  imageUrl: state.profile['image'] ?? "",
                                  width: 100.w,
                                  height: 100.h,
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
                          ],
                        ),
                      ),
                      ProfileItem(
                          title: LocaleKeys.specialization.tr(),
                          icon: Icons.medical_services,
                          value: state.profile['specialization'] ?? ""),
                      ProfileItem(
                        title: LocaleKeys.age.tr(),
                        value: state.profile['birthDate'] ?? "",
                        icon: Icons.calendar_today,
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
                          SharedHelper.clear();
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
