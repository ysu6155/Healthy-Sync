import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/widgets/ui_helpers.dart';
import 'package:healthy_sync/feature/patients/medical_tests/presentation/lab_test_details/screen/lab_test_details_screen.dart';
import 'package:healthy_sync/feature/patients/medical_tests/presentation/lab_tests/cubit/lab_tests_cubit.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';

class LabTestsScreen extends StatelessWidget {
  const LabTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LabTestsCubit()..loadData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 56.sp,
          centerTitle: true,
          elevation: 0,
          title: Text(
            LocaleKeys.labTests.tr(),
            style: TextStyles.font16DarkBlueW500,
          ),
          backgroundColor: AppColor.white,
        ),
        body: BlocBuilder<LabTestsCubit, LabTestsState>(
          builder: (context, state) {
            if (state is LabTestsLoading) {
              return showLoading();
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  // قسم التصفية
                  Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.testType.tr(),
                          style: TextStyles.font16DarkBlueW500,
                        ),
                        16.H,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildFilterChip(
                                LocaleKeys.bloodTest.tr(),
                                true,
                                () {},
                              ),
                              8.W,
                              _buildFilterChip(
                                LocaleKeys.urineTest.tr(),
                                false,
                                () {},
                              ),
                              8.W,
                              _buildFilterChip(
                                LocaleKeys.stoolTest.tr(),
                                false,
                                () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // قسم التحاليل
                  Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state is LabTestsLoaded)
                          ...state.labTests
                              .map((test) => _buildTestCard(context, test)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    String text,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.sp,
          vertical: 6.sp,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.mainBlue
              : AppColor.mainBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColor.mainBlue,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildTestCard(BuildContext context, Map<String, dynamic> test) {
    final isCompleted = test['status'] == LocaleKeys.completed.tr();

    return Container(
      margin: EdgeInsets.only(bottom: 12.sp),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey.withValues(alpha: 0.3),
            spreadRadius: 0.4,
            blurRadius: 4.4,
            offset: Offset(0, 0.4),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          if (isCompleted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LabTestDetailsScreen(
                  testData: test,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  LocaleKeys.resultsNotAvailable.tr(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: AppColor.orange,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            );
          }
        },
        contentPadding: EdgeInsets.all(12.sp),
        leading: Container(
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            color: _getTypeColor(test['type']).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            _getTypeIcon(test['type']),
            size: 24.sp,
            color: _getTypeColor(test['type']),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                test['name'] ?? '',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.mainBlueDark,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.sp,
                vertical: 4.sp,
              ),
              decoration: BoxDecoration(
                color: isCompleted
                    ? AppColor.green.withOpacity(0.1)
                    : AppColor.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                test['status'] ?? '',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: isCompleted ? AppColor.green : AppColor.orange,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            8.H,
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 14.sp,
                  color: AppColor.grey,
                ),
                4.W,
                Text(
                  test['date'] ?? '',
                  style: TextStyles.font12GreyW400,
                ),
                16.W,
                Icon(
                  Icons.person_outline,
                  size: 14.sp,
                  color: AppColor.grey,
                ),
                4.W,
                Text(
                  test['doctor'] ?? '',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColor.mainBlue,
                  ),
                ),
              ],
            ),
            4.H,
            Text(
              test['type'] ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                color: _getTypeColor(test['type']),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String? type) {
    if (type == null) return AppColor.mainBlue;

    switch (type) {
      case 'تحليل دم':
        return AppColor.mainBlue;
      case 'تحليل بول':
        return AppColor.mainPink;
      case 'تحليل براز':
        return AppColor.green;
      default:
        return AppColor.mainBlue;
    }
  }

  IconData _getTypeIcon(String? type) {
    if (type == null) return Icons.science_outlined;

    switch (type) {
      case 'تحليل دم':
        return Icons.bloodtype_outlined;
      case 'تحليل بول':
        return Icons.water_drop_outlined;
      case 'تحليل براز':
        return Icons.science_outlined;
      default:
        return Icons.science_outlined;
    }
  }
}
