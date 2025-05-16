import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/feature/lab/profile/presentation/screens/edit_profile.dart';
import 'package:healthy_sync/feature/lab/report/presentation/pages/report.dart';
import 'package:healthy_sync/feature/welcome/presentation/screens/intro/intro_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileLabScreen extends StatelessWidget {
  const ProfileLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48.sp,
        backgroundColor: AppColor.white,
        title: Text(
          "الإعدادات",
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
                    color: AppColor.mainBlue.withOpacity(0.6),
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
                    // هنا ممكن تحط لوجو المعمل أو الصيدلية
                    backgroundImage: const NetworkImage(
                        'https://images.pexels.com/photos/220458/pexels-photo-220458.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'), // غيرها حسب مكان الصورة
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          SharedHelper.get(SharedKeys.name) ?? "Alfa Lab",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.mainBlue,
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
                              alignment: Alignment.center,
                              width: 200.sp,
                              height: 200.sp,
                              child: QrImageView(
                                data:
                                    SharedHelper.get(SharedKeys.id).toString(),
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
                      color: AppColor.mainBlue,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(16),
            ProfileItem(
              title: "تعديل الملف الشخصي",
              icon: Icons.edit,
              onTap: () {
                context.push(const EditProfileLab());
              },
            ),
            ProfileItem(
              title: "تغيير كلمة المرور",
              icon: Icons.password,
              onTap: () {
                // Navigate to update password
              },
            ),
            ProfileItem(
              title: "تغيير اللغة",
              value: LocaleKeys.languageNaw.tr(),
              icon: Icons.language,
              onTap: () {
                if (context.locale.toString() == 'ar') {
                  context.setLocale(Locale('en'));
                } else {
                  context.setLocale(Locale('ar'));
                }
              },
            ),
            ProfileItem(
              title: "تسجيل الخروج",
              icon: Icons.logout,
              onTap: () {
                SharedHelper.removeKey(SharedKeys.kToken);
                context.pushAndRemoveUntil(IntroScreen());
              },
            ),
            Gap(15),
          ],
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
            color: AppColor.grey.withOpacity(0.3),
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
        leading: Icon(icon, color: AppColor.mainBlue, size: 30.sp),
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
