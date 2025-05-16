import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_sync/core/constants/enum.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';
import 'package:healthy_sync/feature/authentication/presentation/screens/login/login_screen.dart';
import 'package:healthy_sync/feature/welcome/presentation/screens/intro/role_selection_page.dart';
import 'package:healthy_sync/feature/welcome/presentation/widgets/build_dot.dart'
    show buildDot;
import 'package:healthy_sync/core/widgets/custom_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CarouselSlider(
            carouselController: _carouselController, // لازم تعرفه وتربطه

            items: [
              getStartPage(),
              RoleSelectionPage(carouselController: _carouselController),
            ],
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              },
              height: MediaQuery.of(context).size.height - 30.sp,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: false,
              autoPlay: false,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              2,
              (index) => buildDot(index: index, currentPage: _currentPage),
            ),
          ),
          4.H,
        ],
      ),
    );
  }

  Widget getStartPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.locale.languageCode == 'ar' ? arWidget() : enWidget(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              25.H,
              Row(
                children: [
                  Text(
                    LocaleKeys.selectLanguage.tr(),
                    style: TextStyle(
                      color: AppColor.textColorGray,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  10.W,
                  Icon(Icons.language, color: AppColor.mainPink, size: 25.sp),
                ],
              ),
              15.H,
              GestureDetector(
                onTap: () {
                  final currentLocale = context.locale;
                  if (currentLocale.languageCode == 'ar') {
                    context.setLocale(const Locale('en'));
                  } else {
                    context.setLocale(const Locale('ar'));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColor.mainPink.withOpacity(.4),
                      width: 1.0,
                    ),
                  ),
                  child: CustomTextField(
                    isEnabled: false,
                    hintText: LocaleKeys.languageXNaw.tr(),
                    hintTextStyle: TextStyle(
                      color: AppColor.textColorGray,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
              35.H,
              Center(
                child: CustomButton(
                  width: 1.sw - 130.sp,
                  name: LocaleKeys.registerNow.tr(),
                  onTap: () {
                    _carouselController.nextPage(
                      curve: Curves.easeInOut,
                      duration: Durations.extralong1,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column enWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.1416),
              child: SvgPicture.asset(
                AppAssets.ellipse,
                height: ResponsiveHelper.isMobile(context) ? 500.sp : 330.sp,
                width: 1.sw - 40.sp,
                fit: BoxFit.cover,
              ),
            ),
            PositionedDirectional(
              start: 35.sp,
              bottom: 0.sp,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        LocaleKeys.welcomeTo.tr(),
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      4.W,
                      Text(
                        LocaleKeys.healthySync.tr(),
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: AppColor.mainPink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    LocaleKeys.description.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.textColorGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    LocaleKeys.description1.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.textColorGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            PositionedDirectional(
              end: ResponsiveHelper.isMobile(context) ? 20.sp : -120.sp,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.1416),
                child: Image.asset(
                  AppAssets.carry,
                  height: ResponsiveHelper.isMobile(context) ? 106.sp : 70.sp,
                  width: ResponsiveHelper.isMobile(context) ? 106.w : 70.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            PositionedDirectional(
              start: ResponsiveHelper.isMobile(context) ? 50.sp : 0.sp,
              child: Image.asset(
                AppAssets.rivet,
                height: 76.sp,
                width: 76.w,
                fit: BoxFit.cover,
              ),
            ),
            PositionedDirectional(
              top: ResponsiveHelper.isMobile(context) ? 45.sp : 35.sp,
              start: ResponsiveHelper.isMobile(context)
                  ? 0.sp
                  : MediaQuery.of(context).size.width / 5,
              child: Image.asset(
                AppAssets.welcome,
                width: ResponsiveHelper.isMobile(context)
                    ? 1.sw - 60.sp
                    : 1.sw - 120.sp,
                fit: BoxFit.cover,
              ),
            ),
            PositionedDirectional(
              start: ResponsiveHelper.isMobile(context) ? 35.sp : 15.sp,
              top: ResponsiveHelper.isMobile(context) ? 320.sp : 200.sp,
              child: Image.asset(
                AppAssets.tist,
                height: ResponsiveHelper.isMobile(context) ? 95.sp : 70.sp,
                width: ResponsiveHelper.isMobile(context) ? 95.w : 70.w,
                fit: BoxFit.cover,
              ),
            ),
            PositionedDirectional(
              start: ResponsiveHelper.isMobile(context) ? 280.sp : 310.sp,
              top: ResponsiveHelper.isMobile(context) ? 200.sp : 140.sp,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.1416),
                child: Image.asset(
                  AppAssets.syringe1,
                  height: ResponsiveHelper.isMobile(context) ? 106.sp : 70.sp,
                  width: ResponsiveHelper.isMobile(context) ? 106.w : 70.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column arWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: RepaintBoundary(
                child: SvgPicture.asset(
                  AppAssets.ellipse,
                  height: ResponsiveHelper.isMobile(context) ? 500.sp : 330.sp,
                  width: 1.sw - 40.sp,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            PositionedDirectional(
              start: 63.sp,
              bottom: 0.sp,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        LocaleKeys.welcomeTo.tr(),
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      4.W,
                      Text(
                        LocaleKeys.healthySync.tr(),
                        style: TextStyle(
                          fontSize: 25.sp,
                          color: AppColor.mainPink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    LocaleKeys.description.tr(),
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColor.textColorGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    LocaleKeys.description1.tr(),
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColor.textColorGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            PositionedDirectional(
              end: ResponsiveHelper.isMobile(context) ? 50.sp : 0.sp,
              child: Image.asset(
                AppAssets.carry,
                height: ResponsiveHelper.isMobile(context) ? 106.sp : 70.sp,
                width: ResponsiveHelper.isMobile(context) ? 106.w : 70.w,
                fit: BoxFit.cover,
              ),
            ),
            PositionedDirectional(
              start: ResponsiveHelper.isMobile(context) ? 50.sp : 0.sp,
              child: Image.asset(
                AppAssets.rivet,
                height: 76.sp,
                width: 76.w,
                fit: BoxFit.cover,
              ),
            ),
            PositionedDirectional(
              top: ResponsiveHelper.isMobile(context) ? 45.sp : 15.sp,
              start: ResponsiveHelper.isMobile(context)
                  ? 0.sp
                  : MediaQuery.of(context).size.width / 5,
              child: Image.asset(
                AppAssets.welcome,
                width: ResponsiveHelper.isMobile(context)
                    ? 1.sw - 60.sp
                    : 1.sw - 150.sp,
                fit: BoxFit.cover,
              ),
            ),
            PositionedDirectional(
              end: ResponsiveHelper.isMobile(context) ? -10.sp : 0.sp,
              top: ResponsiveHelper.isMobile(context) ? 200.sp : 140.sp,
              child: Image.asset(
                AppAssets.syringe1,
                height: ResponsiveHelper.isMobile(context) ? 106.sp : 70.sp,
                width: ResponsiveHelper.isMobile(context) ? 106.w : 70.w,
                fit: BoxFit.cover,
              ),
            ),
            PositionedDirectional(
              start: ResponsiveHelper.isMobile(context) ? 35.sp : 10.sp,
              top: ResponsiveHelper.isMobile(context) ? 320.sp : 200.sp,
              child: Image.asset(
                AppAssets.tist,
                height: ResponsiveHelper.isMobile(context) ? 95.sp : 70.sp,
                width: ResponsiveHelper.isMobile(context) ? 95.w : 70.w,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
