import 'package:flutter/material.dart';
import 'package:healthy_sync/Screens/LoginScreen.dart';
import 'package:healthy_sync/Themes/Themedata.dart';
import 'package:healthy_sync/Widgets/BuildPgeWelcome.dart';
import 'package:healthy_sync/Widgets/Button.dart';
import 'package:healthy_sync/unts/AppColor.dart';

import '../Widgets/buildDot.dart';

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
                  image: "assets/images/image1.png",
                  title: "Welcome to Healthy Sync",
                  description: "we help you to live a healthy life",
                ),
                buildPage(
                  image: "assets/images/image2.png",
                  title: "easy to use",
                  description: "easy to use and simple design",
                ),
                buildPage(
                  image: "assets/images/image3.png",
                  title: "Join us now",
                  description: "ready to start your journey",
                ),
              ],
            ),
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ...List.generate(
                        3, // عدد الصفحات
                            (index) => buildDot(index: index, currentPage: _currentPage),
                      ),
                    ]),
                    SizedBox(height: 20),
                    if (_currentPage == 2)
                      Column(
                        children: [
                          Button(name: Text("start now",style: textButtomStyle,),
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                      (route) => false,
                                );
                              }
                          ),
                          SizedBox(height: 60),
                        ],
                      )
                    else
                      Column(
                        children: [
                          Button(
                            name: Text("next",style: textButtomStyle,),
                            onTap: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            },
                          ),
                          SizedBox(height: 16),
                          Button(
                            name: Text("skip",style: textButtomStyle,),
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
