import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/feature/patients/data/data.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/medical_tests/tests_screen.dart';

class MedicalTestsScreen extends StatelessWidget {
  const MedicalTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uniqueTests =
        tests
            .fold<Map<String, Map<String, dynamic>>>({}, (acc, test) {
              acc[test['name']] = test;
              return acc;
            })
            .values
            .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.tests.tr(),
          style: textStyleTitle.copyWith(color: AppColor.black),
        ),
        backgroundColor: AppColor.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.sp,
                  mainAxisSpacing: 10.sp,
                  childAspectRatio: 1.sp,
                ),
                itemCount: uniqueTests.length,
                itemBuilder: (context, index) {
                  return Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColor.main, width: 2.w),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          uniqueTests[index]['icon'],
                          size: 40.sp,
                          color: AppColor.main,
                        ),
                        10.H,
                        Text(
                          uniqueTests[index]['name'],
                          style: textStyleTitle.copyWith(color: AppColor.black),
                        ),
                        5.H,
                        Text(
                          uniqueTests[index]['desc'],
                          textAlign: TextAlign.center,
                          style: textStyle.copyWith(color: AppColor.black),
                        ),
                      ],
                    ),
                  ).withTapEffect(
                    highlightColor: AppColor.secondary,
                    splashColor: AppColor.secondary,
                    onTap: () {
                      context.push(TestsScreen(test: uniqueTests[index]));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
