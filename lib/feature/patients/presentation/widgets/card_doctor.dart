import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/utils/app_color.dart';

class CardDoctor extends StatelessWidget {
  const CardDoctor({super.key, required this.doctor, required this.index});
  final int index;
  final dynamic doctor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.all(10.sp),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      tileColor: AppColor.main, //colorSpecializations[index],

      leading: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: CachedNetworkImage(
          imageUrl: doctor["image"]!,
          height: 75.sp,
          width: 75.sp,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        doctor["name"]!,
        style: TextStyle(
          color: AppColor.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        doctor["specialty"]!,
        style: TextStyle(color: AppColor.white, fontSize: 14.sp),
      ),
      trailing: SizedBox(
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
    );
  }
}
// Ink(
//               decoration: BoxDecoration(
//                 color: colorSpecializations[index],
//                 borderRadius: BorderRadius.circular(16.r),
//               ),
              
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(16.r),
//             child: CachedNetworkImage(
//               imageUrl: doctor["image"]!,
//               height: 75.sp,
//               width: 75.sp,
//               fit: BoxFit.cover,
//             ),
//           ),
//           8.H,
//           Text(
//             doctor["name"]!,
//             style: TextStyle(
//               color: AppColor.white,
//               fontSize: 16.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             doctor["specialty"]!,
//             style: TextStyle(color: AppColor.white, fontSize: 14.sp),
//           ),
//           8.H,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(5, (index) {
//               double rat = doctor["rating"] ?? 0;
//               return Icon(
//                 Icons.star,
//                 color: index < rat ? AppColor.amber : AppColor.grey,
//                 size: 20.sp,
//               );
//             }),
//           ),
//         ],
//       ),
//     );