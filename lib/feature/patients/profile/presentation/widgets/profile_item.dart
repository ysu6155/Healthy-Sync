import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String? value;
  final IconData icon;
  final VoidCallback? onTap;

  const ProfileItem({
    required this.title,
    this.value,
    required this.icon,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 6.sp),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        leading: Icon(icon, color: AppColor.mainPink, size: 30.sp),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.black,
          ),
        ),
        subtitle: value != null
            ? Text(
                value!,
                style: TextStyle(fontSize: 14.sp, color: AppColor.grey),
              )
            : null,
        trailing: onTap != null
            ? Icon(Icons.arrow_forward_ios, color: AppColor.grey)
            : null,
        onTap: onTap,
      ),
    );
  }
}
