import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
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
          style: textStyleTitle.copyWith(color: AppColor.black),
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
                  child: CachedNetworkImage(
                    imageUrl: test["image"],
                    height: 200.sp,
                  ),
                ),
              ),
            ),
            const Gap(20),
            Text(
              test['name'],
              style: textStyleTitle.copyWith(color: AppColor.black),
            ),
            const Gap(10),
            Text(
              test['desc'],
              style: textStyleBody.copyWith(color: AppColor.black),
            ),
            Gap(20),
            Text(
              LocaleKeys.details.tr(),
              style: textStyleBody.copyWith(color: AppColor.black),
            ),
            Gap(4),
            Text(
              test['details'],
              style: textStyleBody.copyWith(color: AppColor.black),
            ),
            Gap(20),

            Text(
              LocaleKeys.value.tr(),
              style: textStyleBody.copyWith(color: AppColor.black),
            ),
            Gap(4),
            values is Map<String, dynamic>
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      values.entries.map<Widget>((entry) {
                        return Text(
                          "${entry.key}: ${entry.value}",
                          style: textStyleBody.copyWith(color: AppColor.black),
                        );
                      }).toList(),
                )
                : Text(
                  LocaleKeys.noDataFound.tr(),
                  style: textStyleBody.copyWith(color: AppColor.red),
                ),
            15.H,
            Row(
              children: [
                Icon(Icons.info, color: test['color'], size: 24.sp),
                10.W,
                Text(
                  test['status'],
                  style: textStyleTitle.copyWith(color: test['color']),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
