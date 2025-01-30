import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/generated/l10n.dart';
import 'package:healthy_sync/view/Widgets/Button.dart';
import 'package:healthy_sync/view_model/Themes/Themedata.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';

class DoctorDetails extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorDetails({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48.sp,
        title: Text(doctor["name"], style: textButtonStyle),
        iconTheme:  IconThemeData(color: AppColor.white,size: 16.sp),
        backgroundColor: AppColor.main,
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0.sp
        ),
        child: ListView(
          children: [
            Center(
              child: Container(
                width: double.infinity.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Image.asset(doctor["image"],fit: BoxFit.cover,),
              ),
            ),
             SizedBox(height: 16.sp),
            Text(
              "${S.of(context).name}: ${doctor["name"]}",
              style:  TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 8.sp),
            Text(
              "${S.of(context).specialization}: ${doctor["specialty"]}",
              style:  TextStyle(
                fontSize: 16.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8.sp),
            Row(
              children: [
                 Icon(Icons.star, color: Colors.amber,size: 16.sp,),
                 SizedBox(width: 4.sp),
                Text(
                  "Rating: ${doctor["rating"]}/5.0",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
             SizedBox(height: 16.sp),
             Text(
              "${S.of(context).AboutDoctor}:",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 8.sp),
            Text(
              doctor["about"] ?? S.of(context).NoAdditionalInformationProvided,
              style:  TextStyle(fontSize: 16.sp),
            ),
            SizedBox(
              height: 16.sp,
            ),
            Button(
              name: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).callDoctor,style: textButtonStyle,),
                  SizedBox(width: 8.w),
                  Icon(Icons.call,color: AppColor.white,size: 16.sp,),
                ],
              ),
              onTap: () {},
            ),
            SizedBox(
              height: 8.sp,
            ),
            Button(
              name: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).chatWithDoctor,style: textButtonStyle,),
                  SizedBox(width: 8.w),
                  Icon(Icons.chat,color: AppColor.white,size: 16.sp,),
                ],
              ),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
