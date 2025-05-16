import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:lottie/lottie.dart';

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

showLoading() {
  return Center(child: Lottie.asset(AppAssets.loading3));
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
