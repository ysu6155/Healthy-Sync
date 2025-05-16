import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';

class CardDoctor extends StatelessWidget {
  const CardDoctor({super.key, required this.doctor, required this.index});
  final int index;
  final dynamic doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color(0xFFF8FAFC), // لون أبيض فاتح جداً
            const Color(0xFFF1F5F9), // لون رمادي فاتح جداً
            const Color(0xFFE2E8F0), // لون رمادي فاتح
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCBD5E0).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          // عناصر زخرفية محسنة
          Positioned(
            right: -20.w,
            top: -20.h,
            child: Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFE2E8F0).withOpacity(0.4),
                    const Color(0xFFE2E8F0).withOpacity(0.1),
                  ],
                  stops: const [0.3, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            left: -15.w,
            bottom: -15.h,
            child: Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFE2E8F0).withOpacity(0.4),
                    const Color(0xFFE2E8F0).withOpacity(0.1),
                  ],
                  stops: const [0.3, 1.0],
                ),
              ),
            ),
          ),
          // محتوى البطاقة
          Padding(
            padding: EdgeInsets.all(16.sp),
            child: Row(
              children: [
                // صورة الطبيب مع تحسين الإطار
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                      color: const Color(0xFFCBD5E0).withOpacity(0.6),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: CachedNetworkImage(
                      imageUrl: doctor["image"]!,
                      height: 75.sp,
                      width: 75.sp,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                16.W,
                // معلومات الطبيب مع تحسين التصميم
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        doctor["name"]!,
                        style: TextStyle(
                          color: const Color(0xFF1E293B),
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          letterSpacing: 0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      6.H,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.sp,
                          vertical: 5.sp,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFFE2E8F0).withOpacity(0.6),
                              const Color(0xFFE2E8F0).withOpacity(0.4),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: const Color(0xFFCBD5E0).withOpacity(0.6),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          LocaleKeys.rating.tr(),
                          style: TextStyle(
                            color: const Color(0xFF475569),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                      8.H,
                    ],
                  ),
                ),
                // تقييم الطبيب مع تحسين التصميم
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.sp,
                    vertical: 6.sp,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFE2E8F0).withOpacity(0.6),
                        const Color(0xFFE2E8F0).withOpacity(0.4),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: const Color(0xFFCBD5E0).withOpacity(0.6),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: AppColor.amber,
                        size: 18.sp,
                      ),
                      4.W,
                      Text(
                        "${doctor["rating"] ?? 0}",
                        style: TextStyle(
                          color: const Color(0xFF475569),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
