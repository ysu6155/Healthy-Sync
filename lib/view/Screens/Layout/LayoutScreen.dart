import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_sync/generated/l10n.dart';
import 'package:healthy_sync/view/Screens/home/HomeScreen.dart';
import 'package:healthy_sync/view_model/utils/AppAssets.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';

class TapBarScreen extends StatefulWidget {

  @override
  State<TapBarScreen> createState() => _TapBarScreenState();
}

class _TapBarScreenState extends State<TapBarScreen> {
  int currentIndex = 0;




  @override
  Widget build(BuildContext context) {
    final List<TabItem> tabItems = [
      TabItem(
        icon: AppAssets.homeIcon,
        label: S.of(context).home,

      ),
      TabItem(
        icon: AppAssets.homeIcon,
        label: S.of(context).home,

      ),
      TabItem(
        icon:  AppAssets.homeIcon,
        label: S.of(context).home,
      ),
    ];
    final List<Widget> screens = [
      HomeScreen(),
      Scaffold(),
      Scaffold(),

    ];
    return Scaffold(

      body: Stack(
        children: [
          screens[currentIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(

              margin: EdgeInsets.symmetric(horizontal: 16.sp,vertical: 24.sp),
              height: 80.sp,
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              decoration: BoxDecoration(
               gradient: AppColor.primaryGradient,
               //  color: AppColor.main,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(tabItems.length, (index) {
                  final tabItem = tabItems[index];
                  return InkWell(
                    onTap: () => setState(() => currentIndex = index),
                    child: Container(
                      alignment: Alignment.center,
                      height: 56.sp,
                      width: currentIndex == index ? 150.w : 56.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: currentIndex == index
                              ? AppColor.white
                              : AppColor.main,
                          width: 2.w,
                        ),
                        color: currentIndex == index
                            ? AppColor.secondary
                            :  AppColor.main,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            tabItem.icon,height: 25.sp,width: 25.w,
                            colorFilter:ColorFilter.mode( AppColor.white, BlendMode.srcIn)

                          ),
                          if (currentIndex == index)
                            Text(
                              "  ${tabItem.label}",
                              style: TextStyle(fontSize: 14.sp, color: AppColor.white),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ),

            ),
          ),
        ],
      ),
    );
  }
}

class TabItem {
  final String icon;
  final String label;


  TabItem({
    required this.icon,
    required this.label,

  });
}
