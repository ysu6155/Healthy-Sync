import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/feature/patients/data/data.dart';
import 'package:healthy_sync/feature/patients/presentation/screens/medical_tests/test_details_screen.dart';

class TestsScreen extends StatelessWidget {
  final Map<String, dynamic> test;

  const TestsScreen({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          test['name'],
          style: textStyleTitle.copyWith(color: AppColor.black),
        ),
        backgroundColor: AppColor.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.H,
            Text(
              test['desc'],
              style: textStyleBody.copyWith(color: AppColor.black),
            ),
            20.H,
            Expanded(
              child: ListView.builder(
                itemCount: tests.where((t) => t['name'] == test['name']).length,
                itemBuilder: (context, index) {
                  final filteredTests =
                      tests.where((t) => t['name'] == test['name']).toList();
                  return Card(
                    color: AppColor.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: BorderSide(color: AppColor.mainPink, width: 2.sp),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8.w),
                    child: ListTile(
                      title: Text(
                        '${filteredTests[index]['name']} ${index + 1}',
                        style: textStyleBody.copyWith(color: AppColor.black),
                      ),
                      subtitle: Text(
                        "${LocaleKeys.date.tr()} : ${DateFormat('yyyy-MM-dd').format(filteredTests[index]['dateTime'])}",
                        style: textStyle.copyWith(color: AppColor.black),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColor.mainPink,
                        size: 24.sp,
                      ),
                    ).withTapEffect(
                      highlightColor: AppColor.secondary,
                      onTap: () {
                        context.push(
                          TestDetailsScreen(test: filteredTests[index]),
                        );
                      },
                    ),
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
