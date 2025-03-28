import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/feature/welcome/presentation/screens/welcome/welcome_screen.dart';
import 'package:healthy_sync/feature/welcome/presentation/widgets/build_dot.dart'
    show buildDot;
import 'package:healthy_sync/feature/welcome/presentation/widgets/build_pge_welcome.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        actions: [
          TextButton(
            onPressed: () {
              SharedHelper.sava(SharedKeys.isOnboardingShown, true);
              context.pushReplacement(WelcomeScreen());
            },
            child: Text(
              LocaleKeys.skip.tr(),
              style: TextStyles.font20PinkBold,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: [
              buildPage(
                context: context,
                image: AppAssets.image1,
                title: LocaleKeys.welcomeToHealthySync.tr(),
                description: LocaleKeys.Empoweringyoutoliveahealthierlife.tr(),
              ),
              buildPage(
                context: context,
                image: AppAssets.image2,
                title: LocaleKeys.easyToUse.tr(),
                description: LocaleKeys.easyToUseAndSimple.tr(),
              ),
              buildPage(
                context: context,
                image: AppAssets.image3,
                title: LocaleKeys.joinNow.tr(),
                description: LocaleKeys.readyToStartYourSync.tr(),
              ),
            ],
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              },
              height: ResponsiveHelper.isMobile(context) ? 550.sp : 440.sp,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                3,
                (index) => buildDot(index: index, currentPage: _currentPage),
              ),
              Spacer(),
              if (_currentPage == 2)
                CustomButton(
                  height: 45.sp,
                  width: 100.sp,
                  name:" LocaleKeys.getStarted.tr(),",
                  onTap: () {
                    SharedHelper.sava(SharedKeys.isOnboardingShown, true);
                    context.pushReplacement(WelcomeScreen());
                  },
                ),
            ],
          ).paddingDirectional(start: 16.sp, end: 16.sp),
          Spacer(),
        ],
      ),
    );
  }
}
