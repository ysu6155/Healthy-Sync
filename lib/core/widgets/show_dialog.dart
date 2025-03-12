import 'package:flutter/material.dart';
import 'package:healthy_sync/core/utils/app_assets.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
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
    builder:
        (context) => Dialog(
          backgroundColor: AppColor.transparent,
          child: Center(child: Lottie.asset(AppAssets.loading3)),
        ),
  );
}

showLoading() {
  return Center(child: Lottie.asset(AppAssets.loading3));
}
