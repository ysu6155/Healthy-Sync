import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/widgets/ui_helpers.dart';
import 'package:healthy_sync/feature/patients/medical_tests/presentation/xray_details/screen/xray_details_screen.dart';
import 'package:healthy_sync/feature/patients/medical_tests/presentation/xray_tests/cubit/xray_tests_cubit.dart';

class XrayScreen extends StatelessWidget {
  const XrayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => XrayTestsCubit()..loadData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 56.sp,
          centerTitle: true,
          elevation: 0,
          title: Text(
            "الأشعة",
            style: TextStyles.font16DarkBlueW500,
          ),
          backgroundColor: AppColor.white,
        ),
        body: BlocBuilder<XrayTestsCubit, XrayTestsState>(
          builder: (context, state) {
            if (state is XrayTestsLoading) {
              return showLoading();
            }

            return RefreshIndicator(
              onRefresh: () async {
                await context.read<XrayTestsCubit>().refresh();
              },
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state is XrayTestsLoaded) ...[
                          Row(
                            children: [
                              _buildFilterButton(
                                context,
                                'آخر 3 شهور',
                                '3_months',
                                state.filterPeriod == '3_months',
                              ),
                              8.W,
                              _buildFilterButton(
                                context,
                                'هذا العام',
                                'this_year',
                                state.filterPeriod == 'this_year',
                              ),
                              8.W,
                              _buildFilterButton(
                                context,
                                'آخر 6 أشهر',
                                '6_months',
                                state.filterPeriod == '6_months',
                              ),
                              8.W,
                              _buildFilterButton(
                                context,
                                "مخصص",
                                'custom',
                                state.filterPeriod == 'custom',
                              ),
                            ],
                          ),
                          16.H,
                          ...state.xrayTests
                              .map((test) => _buildTestCard(context, test)),
                        ],
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

  Widget _buildFilterButton(
    BuildContext context,
    String text,
    String period,
    bool isSelected,
  ) {
    return InkWell(
      onTap: () async {
        if (isSelected) {
          context.read<XrayTestsCubit>().clearFilter();
        } else if (period == 'custom') {
          final DateTimeRange? dateRange = await showDateRangePicker(
            context: context,
            firstDate: DateTime(2020),
            lastDate: DateTime.now(),
            initialDateRange: DateTimeRange(
              start: DateTime.now().subtract(const Duration(days: 30)),
              end: DateTime.now(),
            ),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColor.mainBlue,
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: AppColor.mainBlueDark,
                  ),
                ),
                child: child!,
              );
            },
          );

          if (dateRange != null) {
            await context.read<XrayTestsCubit>().filterByPeriod(
                  'custom',
                  dateRange.start,
                  dateRange.end,
                );
          }
        } else {
          await context.read<XrayTestsCubit>().filterByPeriod(period);
        }
      },
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
    final isCompleted = test['status'] == 'مكتمل';

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
                builder: (context) => XrayDetailsScreen(
                  xrayData: test,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'النتائج غير متاحة بعد',
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
      case 'أشعة سينية':
        return AppColor.mainBlue;
      case 'رنين مغناطيسي':
        return AppColor.mainPink;
      case 'أشعة مقطعية':
        return AppColor.green;
      default:
        return AppColor.mainBlue;
    }
  }

  IconData _getTypeIcon(String? type) {
    if (type == null) return Icons.medical_information_outlined;

    switch (type) {
      case 'أشعة سينية':
      case 'رنين مغناطيسي':
      case 'أشعة مقطعية':
        return Icons.medical_information_outlined;
      default:
        return Icons.medical_information_outlined;
    }
  }
}
