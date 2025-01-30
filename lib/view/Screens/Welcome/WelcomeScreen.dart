import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/generated/l10n.dart';
import 'package:healthy_sync/view/Screens/Welcome/Widgets/BuildPgeWelcome.dart';
import 'package:healthy_sync/view/Screens/login/LoginScreen.dart';
import 'package:healthy_sync/view/Widgets/Button.dart';
import 'package:healthy_sync/view_model/Themes/Themedata.dart';
import 'package:healthy_sync/view_model/utils/AppAssets.dart';
import 'package:healthy_sync/view_model/utils/AppColor.dart';

import 'Widgets/buildDot.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController _pageController = PageController();
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
                  title: S.of(context).welcomeToHealthySync,
                  description: S.of(context).Empoweringyoutoliveahealthierlife,
                ),
                buildPage(
                  image: AppAssets.image2,
                  title: S.of(context).easyToUse,
                  description: S.of(context).easyToUseAndSimple,
                ),
                buildPage(
                  image: AppAssets.image3,
                  title: S.of(context).joinNow,
                  description: S.of(context).readyToStartYourSync,
                ),
              ],
            ),
            Positioned(
              bottom: 30.sp,
              left: 0.sp,
              right: 0.sp,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ...List.generate(
                        3, // عدد الصفحات
                        (index) =>
                            buildDot(index: index, currentPage: _currentPage),
                      ),
                    ]),
                    SizedBox(height: 20.sp),
                    if (_currentPage == 2)
                      Column(
                        children: [
                          Button(
                              name: Text(
                                S.of(context).startNow,
                                style: textButtonStyle,
                              ),
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                  (route) => false,
                                );
                              }),
                          SizedBox(height: 60.sp),
                        ],
                      )
                    else
                      Column(
                        children: [
                          Button(
                            name: Text(
                              S.of(context).next,
                              style: textButtonStyle,
                            ),
                            onTap: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            },
                          ),
                          SizedBox(height: 16),
                          Button(
                            name: Text(
                              S.of(context).skip,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
