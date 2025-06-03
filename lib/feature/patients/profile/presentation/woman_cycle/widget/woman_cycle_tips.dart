import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WomanCycleTips extends StatefulWidget {
  const WomanCycleTips({super.key});

  @override
  State<WomanCycleTips> createState() => _WomanCycleTipsState();
}

class _WomanCycleTipsState extends State<WomanCycleTips> {
  int currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  final List<String> tips = [
    LocaleKeys.tipStayHydrated.tr(),
    LocaleKeys.tipAvoidColdDrinks.tr(),
    LocaleKeys.tipLightExercise.tr(),
    LocaleKeys.tipIronRichFoods.tr(),
    LocaleKeys.tipGetRest.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: tips.length,
          itemBuilder: (context, index, pageIndex) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColor.mainPink.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColor.mainPink, width: 1),
              ),
              child: Center(
                child: Text(
                  tips[index],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.mainPink,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 160.sp,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.85,
            autoPlayInterval: const Duration(seconds: 5),
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: 10.sp),
        AnimatedSmoothIndicator(
          activeIndex: currentIndex,
          count: tips.length,
          effect: ExpandingDotsEffect(
            activeDotColor: AppColor.mainPink,
            dotColor: AppColor.grey.withOpacity(0.5),
            dotHeight: 10.sp,
            dotWidth: 15.sp,
            spacing: 6.sp,
          ),
          onDotClicked: (index) => _carouselController.animateToPage(index),
        ),
      ],
    );
  }
}