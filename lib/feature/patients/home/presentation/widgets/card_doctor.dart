import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/themes/app_color.dart';

class CardDoctor extends StatelessWidget {
  const CardDoctor({super.key, required this.doctor, required this.index});
  final int index;
  final dynamic doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: AppColor.mainPink,
        borderRadius: BorderRadius.circular(16.r),
      ),

      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: CachedNetworkImage(
              imageUrl: doctor["image"]!,
              height: 75.sp,
              width: 75.sp,
              fit: BoxFit.cover,
            ),
          ),
          16.W,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor["name"]!,
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                doctor["specialty"]!,
                style: TextStyle(color: AppColor.white, fontSize: 14.sp),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: 60.sp,
            height: 20.sp,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                double rat = doctor["rating"] ?? 0;
                return Icon(
                  Icons.star,
                  color: index < rat ? AppColor.amber : AppColor.grey,
                  size: 12.sp,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
