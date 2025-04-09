import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/feature/patients/home/data/data.dart';
import 'package:healthy_sync/feature/patients/medical_tests/presentation/screens/health_tips.dart';
import 'package:healthy_sync/feature/patients/medical_tests/presentation/screens/tests_screen.dart';

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
        toolbarHeight: 48.sp,
        centerTitle: true,
        title: Text(
          LocaleKeys.tests.tr(),
          style: TextStyles.font16DarkBlueW500,
        ),
        backgroundColor: AppColor.white,
      ),
      body: ListView(
        children: [
          HealthTips(),
          20.H,
          Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: Column(
              children: [
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.sp,
                  mainAxisSpacing: 10.sp,
                  childAspectRatio:
                      ResponsiveHelper.isMobile(context) ? .8.sp : .5.sp,
                  children: [
                    _buildCard("التقارير", Icons.arrow_forward_ios),
                    _buildTapCard(
                      "التحاليل",
                      Icons.arrow_forward_ios,
                      () => context.push(TestsScreen(test: uniqueTests[0])),
                    ),
                    _buildCard("الأشعة", Icons.arrow_forward_ios),
                  ],
                ),
                15.H,
                Text("اخر التحاليل", style: TextStyles.font16DarkBlueW500),
                20.H,
                ListTile(
                  onTap: () {
                    context.push(TestsScreen(test: uniqueTests[1]));
                  },
                  leading: Icon(
                    Icons.bloodtype,
                    size: 20.sp,
                    color: AppColor.mainPink,
                  ),
                  title: Text(
                    "تحليل سكر",
                    style: TextStyles.font16DarkBlueW500,
                  ),
                  subtitle: Text(
                    "2023-10-01",
                    style: TextStyles.font12DarkBlueW400,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20.sp,
                    color: AppColor.mainPink,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, IconData icon) {
    return Card(
      color: AppColor.white,
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyles.font16DarkBlueW500,
              textAlign: TextAlign.center,
            ),
            10.H,
            Icon(icon, size: 20.sp, color: AppColor.mainPink),
          ],
        ),
      ),
    );
  }

  // ✅ كارد فيه OnTap
  Widget _buildTapCard(String title, IconData icon, VoidCallback onTap) {
    return InkWell(onTap: onTap, child: _buildCard(title, icon));
  }

  //  Expanded(
  //               child: GridView.builder(
  //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                   crossAxisCount: 2,
  //                   crossAxisSpacing: 10.sp,
  //                   mainAxisSpacing: 10.sp,
  //                   childAspectRatio: 1.sp,
  //                 ),
  //                 itemCount: uniqueTests.length,
  //                 itemBuilder: (context, index) {
  //                   return Ink(
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(10.r),
  //                       border: Border.all(color: AppColor.mainPink, width: 2.w),
  //                     ),

  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Icon(
  //                           uniqueTests[index]['icon'],
  //                           size: 40.sp,
  //                           color: AppColor.mainPink,
  //                         ),
  //                         10.H,
  //                         Text(
  //                           uniqueTests[index]['name'],
  //                           style: TextStyles.font16DarkBlueW500
  //                         ),
  //                         5.H,
  //                         Text(
  //                           uniqueTests[index]['desc'],
  //                           textAlign: TextAlign.center,
  //                           style:TextStyles.font16DarkBlueW500
  //                         ),
  //                       ],
  //                     ),
  //                   ).withTapEffect(
  //                     highlightColor: AppColor.secondary,
  //                     splashColor: AppColor.secondary,
  //                     onTap: () {
  //                       context.push(TestsScreen(test: uniqueTests[index]));
  //                     },
  //                   );
  //                 },
  //               ),
  //             ),
}
