import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/view/Screens/Welcome/Widgets/build_pge_welcome.dart';
import 'package:healthy_sync/feature/authentication/presentation/screens/login/login_screen.dart';
import 'package:healthy_sync/view/widgets/custom_button.dart';
import 'package:healthy_sync/core/Themes/light_theme.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/utils/app_assets.dart';
import 'package:healthy_sync/core/utils/app_color.dart';
import 'package:healthy_sync/core/utils/extensions.dart';

import 'Widgets/build_dot.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                buildPage(
                  image: AppAssets.image1,
                  title: LocaleKeys.welcomeToHealthySync.tr(),
                  description: LocaleKeys.Empoweringyoutoliveahealthierlife.tr(),
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
            ),
            Positioned(
              bottom: 20.sp,
              left: 0.sp,
              right: 0.sp,
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ...List.generate(
                      3,
                      (index) =>
                          buildDot(index: index, currentPage: _currentPage),
                    ),
                  ]),
                  15.H,
                  if (_currentPage == 2)
                    Column(
                      children: [
                        CustomButton(
                            name: Text(
                              LocaleKeys.startNow.tr(),
                              style: textButtonStyle,
                            ),
                            onTap: () {
                             context.pushReplacement(LoginScreen());
                            }),
                       60.H,
                      ],
                    )
                  else
                    Column(
                      children: [
                        CustomButton(
                          name: Text(
                            LocaleKeys.next.tr(),
                            style: textButtonStyle,
                          ),
                          onTap: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                        ),
                        16.H,
                        CustomButton(
                          name: Text(
                            LocaleKeys.skip.tr(),
                            style: textButtonStyle,
                          ),
                          backgroundColor: AppColor.primaryGradientLight,
                          textColor: AppColor.black,
                          onTap: () {
                            _pageController.jumpToPage(2);
                          },
                        ),
                      ],
                    ),
                ],
              ).paddingSymmetric(horizontal: 16.w),
            ),
          ],
        ),
      ),
    );
  }
}
