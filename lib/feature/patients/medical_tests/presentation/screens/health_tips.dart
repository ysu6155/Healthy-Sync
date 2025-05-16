import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/feature/patients/home/data/data.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HealthTips extends StatefulWidget {
  const HealthTips({super.key});

  @override
  State<HealthTips> createState() => _HealthTipsState();
}

class _HealthTipsState extends State<HealthTips> {
  int currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: healthTips.length,
          itemBuilder: (BuildContext context, int index, int pageViewIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: healthTips[index],
                fit: BoxFit.fill,
                width: double.infinity,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(color: AppColor.pink),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(
                    Icons.broken_image,
                    size: 50.sp,
                    color: AppColor.mainPink,
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 280.sp,
            viewportFraction: .85,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: 12.sp),
        AnimatedSmoothIndicator(
          activeIndex: currentIndex,
          count: healthTips.length,
          effect: ExpandingDotsEffect(
            expansionFactor: 3,
            activeDotColor: AppColor.mainPink,
            dotColor: AppColor.grey.withOpacity(0.5),
            dotHeight: 10.sp,
            dotWidth: 15.sp,
            spacing: 6.sp,
          ),
          onDotClicked: (index) {
            _carouselController.animateToPage(index);
          },
        ),
      ],
    );
  }
}
