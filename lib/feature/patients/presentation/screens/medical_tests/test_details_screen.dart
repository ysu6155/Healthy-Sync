import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:healthy_sync/core/Themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/medical_tests/image_preview_screen.dart';

class TestDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> test;

  const TestDetailsScreen({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    final values = test['values'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.medicalTest.tr(),
          style: textStyle.copyWith(color: AppColor.black),
        ),
        backgroundColor: AppColor.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              ImagePreviewScreen(imageUrl: test["image"]),
                    ),
                  );
                },
                child: Hero(
                  tag: test["image"],
                  child: Image.asset(test["image"], height: 200.sp),
                ),
              ),
            ),
            const Gap(20),
            Text(
              test['name'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Gap(10),
            Text(
              test['desc'],
              style: TextStyle(fontSize: 16, color: AppColor.grey),
            ),
            Gap(20),
            Text(
              LocaleKeys.details.tr(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(4),
            Text(test['details'], style: const TextStyle(fontSize: 16)),
            Gap(20),

            Text(
              LocaleKeys.value.tr(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(4),
            values is Map<String, dynamic>
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      values.entries.map<Widget>((entry) {
                        return Text(
                          "${entry.key}: ${entry.value}",
                          style: TextStyle(fontSize: 16.sp),
                        );
                      }).toList(),
                )
                : Text(
                  LocaleKeys.noDataFound.tr(),
                  style: TextStyle(fontSize: 16.sp, color: AppColor.red),
                ),
            15.H,
            Row(
              children: [
                Icon(Icons.info, color: test['color'], size: 24.sp),
                10.W,
                Text(
                  test['status'],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: test['color'],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
