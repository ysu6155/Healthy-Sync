import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:lottie/lottie.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';

showErrorToast(BuildContext context, String error) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(error), backgroundColor: AppColor.red));
}

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: AppColor.transparent,
      child: Center(child: Lottie.asset(AppAssets.loading3)),
    ),
  );
}

Widget showLoading() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(AppAssets.loading3),
      ],
    ),
  );
}

void showSuccessSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColor.green,
      duration: const Duration(seconds: 2),
      padding: EdgeInsets.all(
        ResponsiveHelper.isMobile(context) ? 8.sp : 20.sp,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),

      //
      width: MediaQuery.of(context).size.width - 40.sp,
      content: Row(
        children: [
          Text(message, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
          const Spacer(),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: Text(
              'حسنا',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    ),
  );
}

void showErrorSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColor.red,
      duration: const Duration(seconds: 2),
      padding: EdgeInsets.all(
        ResponsiveHelper.isMobile(context) ? 8.sp : 20.sp,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),

      //
      width: MediaQuery.of(context).size.width - 40.sp,
      content: Row(
        children: [
          Text(message, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
          const Spacer(),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: Text(
              'حسنا',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildLoading() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: AppColor.mainBlue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.mainBlue),
            strokeWidth: 3.w,
          ),
        ),
      ],
    ),
  );
}

Widget showError({
  required String message,
  required VoidCallback onRetry,
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 48.sp,
          color: AppColor.mainPink,
        ),
        16.H,
        Text(
          message,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColor.mainBlueDark,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        16.H,
        ElevatedButton(
          onPressed: onRetry,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.mainBlue,
            padding: EdgeInsets.symmetric(
              horizontal: 24.sp,
              vertical: 12.sp,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(
            LocaleKeys.retry.tr(),
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}
