import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
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
          LocaleKeys.medicalTest.tr(),
          style: textStyle.copyWith(color: AppColor.black),
        ),
        backgroundColor: AppColor.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2,
                ),
                itemCount: uniqueTests.length,
                itemBuilder: (context, index) {
                  return Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.main, width: 2),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          uniqueTests[index]['icon'],
                          size: 40,
                          color: AppColor.main,
                        ),
                        SizedBox(height: 10),
                        Text(
                          uniqueTests[index]['name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          uniqueTests[index]['desc'],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: AppColor.grey),
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
