import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';
import 'package:healthy_sync/core/service/local/shared_prefs_helper.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/feature/profile/presentation/screens/edit_profile/edit_profile.dart';
import 'package:healthy_sync/feature/welcome/presentation/screens/welcome/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> profileItems = [
      {
        "title": LocaleKeys.editProfile.tr(),
        "value": " ",
        "icon": Icons.person,
      },
      {
        "title": LocaleKeys.email.tr(),
        "value": SharedHelper.get(SharedKeys.email) ?? "",
        "icon": Icons.email,
      },
      {
        "title": LocaleKeys.phone.tr(),
        "value": SharedHelper.get(SharedKeys.phone) ?? "no phone",
        "icon": Icons.phone,
      },
      {
        "title": LocaleKeys.address.tr(),
        "value": SharedHelper.get(SharedKeys.address) ?? "No Address",
        "icon": Icons.location_on,
      },
      {
        "title": LocaleKeys.language.tr(),
        "value": LocaleKeys.languageNaw.tr(),
        "icon": Icons.language,
      },
      {"title": LocaleKeys.logout.tr(), "value": "", "icon": Icons.logout},
    ];
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
              SharedHelper.removeKay(SharedKeys.kToken);
              context.pushAndRemoveUntil(const WelcomeScreen());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50.r,
                  backgroundImage:
                      Image.network(
                        SharedHelper.get(SharedKeys.image),
                      ).image,
                ),
                16.W,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      SharedHelper.get(SharedKeys.name) ?? "",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.main,
                      ),
                    ),
                    Text(SharedHelper.get(SharedKeys.email) ?? ""),
                  ],
                ),
              ],
            ).paddingAll(16.sp),

            ListView.builder(
              itemCount: profileItems.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = profileItems[index];

                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 16.sp,
                    vertical: 6.sp,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Icon(item["icon"], color: AppColor.main),
                    title: Text(
                      item["title"],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    
                    subtitle:
                        item["value"].isNotEmpty ? Text(item["value"]) : null,
                    trailing:
                        item["title"] == LocaleKeys.logout.tr()
                            ? Icon(Icons.arrow_forward_ios, color: Colors.red)
                            : null,
                  ).withTapEffect(
                    highlightColor: AppColor.secondary,
                    onTap: () {
                      if (item["title"] == LocaleKeys.logout.tr()) {
                        SharedHelper.removeKay(SharedKeys.kToken);
                        context.pushAndRemoveUntil(const WelcomeScreen());
                      } else if (item["title"] == LocaleKeys.language.tr()) {
                        setState(() {
                          log(context.locale.toString());
                          if (context.locale.toString() == 'ar') {
                            context.setLocale(Locale('en'));
                          } else {
                            context.setLocale(Locale('ar'));
                          }
                        });
                      } else if (item["title"] == LocaleKeys.editProfile.tr()) {
                        context.push(EditProfile());
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
