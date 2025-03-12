import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:healthy_sync/core/Themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/feature/medical_tests/data/data.dart';
import 'package:healthy_sync/feature/medical_tests/presentation/screens/test_details_screen.dart';

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
          style: textStyle.copyWith(color: AppColor.black),
        ),
        backgroundColor: AppColor.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              test['desc'],
              style: TextStyle(fontSize: 16, color: AppColor.black),
            ),
            const SizedBox(height: 20),

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
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: AppColor.main, width: 2),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        '${filteredTests[index]['name']} ${index + 1}',
                      ),
                      subtitle: Text(
                        "${LocaleKeys.date.tr()} : ${DateFormat('yyyy-MM-dd').format(filteredTests[index]['dateTime'])}",
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
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
