import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/widgets/shows.dart';
import 'package:healthy_sync/feature/patients/medical_tests/presentation/xray_details/cubit/xray_details_cubit.dart';

class XrayDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> xrayData;

  const XrayDetailsScreen({
    super.key,
    required this.xrayData,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => XrayDetailsCubit(initialData: xrayData),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 56.sp,
          centerTitle: true,
          elevation: 0,
          title: Text(
            LocaleKeys.xrayDetails.tr(),
            style: TextStyles.font16DarkBlueW500,
          ),
          backgroundColor: AppColor.white,
        ),
        body: BlocBuilder<XrayDetailsCubit, XrayDetailsState>(
          builder: (context, state) {
            if (state is XrayDetailsLoading) {
              return showLoading();
            }

            if (state is XrayDetailsLoaded) {
              return RefreshIndicator(
                onRefresh: () => context.read<XrayDetailsCubit>().refresh(),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // صورة الأشعة
                          Container(
                            height: 200.sp,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColor.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12.r),
                              image: DecorationImage(
                                image: NetworkImage(
                                    state.xrayData['imageUrl'] ?? ''),
                                fit: BoxFit.cover,
                                onError: (_, __) => const Center(
                                  child:
                                      Icon(Icons.image_not_supported_outlined),
                                ),
                              ),
                            ),
                          ),
                          24.H,
                          // معلومات الأشعة
                          _buildInfoSection(
                            title: LocaleKeys.examInfo.tr(),
                            children: [
                              _buildInfoRow(
                                icon: Icons.medical_information_outlined,
                                title: LocaleKeys.xrayType.tr(),
                                value: state.xrayData['type'] ?? '',
                                color: _getTypeColor(state.xrayData['type']),
                              ),
                              _buildInfoRow(
                                icon: Icons.description_outlined,
                                title: LocaleKeys.examDescription.tr(),
                                value: state.xrayData['description'] ?? '',
                              ),
                              _buildInfoRow(
                                icon: Icons.calendar_today_outlined,
                                title: LocaleKeys.examDate.tr(),
                                value: state.xrayData['date'] ?? '',
                              ),
                              _buildInfoRow(
                                icon: Icons.person_outline,
                                title: LocaleKeys.doctor.tr(),
                                value: state.xrayData['doctor'] ?? '',
                              ),
                            ],
                          ),
                          24.H,
                          // النتائج
                          _buildInfoSection(
                            title: LocaleKeys.results.tr(),
                            children: [
                              Container(
                                padding: EdgeInsets.all(16.sp),
                                decoration: BoxDecoration(
                                  color: AppColor.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: AppColor.green.withOpacity(0.2),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle_outline,
                                          color: AppColor.green,
                                          size: 20.sp,
                                        ),
                                        8.W,
                                        Text(
                                          LocaleKeys.status.tr(),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.mainBlueDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                    8.H,
                                    Text(
                                      state.xrayData['notes'] ?? '',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColor.mainBlueDark,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          24.H,
                          // زر تحميل التقرير
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () => _downloadReport(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.mainBlue,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 12.sp),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              icon: Icon(
                                Icons.download_outlined,
                                size: 20.sp,
                                color: AppColor.white,
                              ),
                              label: Text(
                                LocaleKeys.downloadReport.tr(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Future<void> _downloadReport(BuildContext context) async {
    try {
      // عرض مؤشر التحميل
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      await context.read<XrayDetailsCubit>().downloadReport();

      // إغلاق مؤشر التحميل
      Navigator.pop(context);

      // عرض رسالة نجاح
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تم تحميل التقرير بنجاح',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColor.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      );
    } catch (e) {
      // إغلاق مؤشر التحميل في حالة الخطأ
      Navigator.pop(context);

      // عرض رسالة الخطأ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'حدث خطأ أثناء تحميل التقرير',
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
  }

  Widget _buildInfoSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.font16DarkBlueW500.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        16.H,
        Container(
          padding: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    Color? color,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
              color: (color ?? AppColor.mainBlue).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              size: 20.sp,
              color: color ?? AppColor.mainBlue,
            ),
          ),
          12.W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColor.grey,
                  ),
                ),
                4.H,
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColor.mainBlueDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String? type) {
    switch (type) {
      case 'أشعة سينية':
        return AppColor.mainBlue;
      case 'أشعة مقطعية':
        return AppColor.mainPink;
      case 'رنين مغناطيسي':
        return AppColor.green;
      default:
        return AppColor.mainBlue;
    }
  }
}
