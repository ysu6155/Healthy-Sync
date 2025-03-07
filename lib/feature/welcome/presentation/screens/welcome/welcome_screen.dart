import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/feature/authentication/presentation/screens/login/login_screen.dart';
import 'package:healthy_sync/core/Themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_assets.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';
import 'package:healthy_sync/feature/authentication/presentation/screens/signup/signup_screen.dart';
import 'package:healthy_sync/feature/welcome/presentation/widgets/build_dot.dart';
import 'package:healthy_sync/feature/welcome/presentation/widgets/build_pge_welcome.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  final pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            CarouselSlider(
              items: [
                buildPage(
                  image: AppAssets.image1,
                  title: LocaleKeys.welcomeToHealthySync.tr(),
                  description:
                      LocaleKeys.Empoweringyoutoliveahealthierlife.tr(),
                ),
                buildPage(
                  image: AppAssets.image2,
                  title: LocaleKeys.easyToUse.tr(),
                  description: LocaleKeys.easyToUseAndSimple.tr(),
                ),
                buildPage(
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
                height: 0.7.sh,
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
            Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ...List.generate(
                    3,
                    (index) =>
                        buildDot(index: index, currentPage: _currentPage),
                  ),
                ]),
                15.H,
                Column(
                  children: [
                    CustomButton(
                      name: Text(
                        LocaleKeys.login.tr(),
                        style: textStyle,
                      ),
                      onTap: () {
                        context.push(LoginScreen());
                      },
                    ),
                    16.H,
                    CustomButton(
                      border: Border.all(color: AppColor.black, width: 3.sp),
                      name:
                          Text(LocaleKeys.signUp.tr(), style: textStyle),
                      backgroundColor: AppColor.main,
                      textColor: AppColor.black,
                      onTap: () {
                        context.push(SignUpScreen());
                      },
                    ),
                  ],
                ),
              ],
            ).paddingSymmetric(horizontal: 16.w, vertical: 16.sp),
          ],
        ),
      ),
    );
  }
}
