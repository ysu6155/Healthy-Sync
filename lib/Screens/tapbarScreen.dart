
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:healthy_sync/Screens/HomeScreen.dart';
import 'package:healthy_sync/unts/AppColor.dart';

class TapBarScreen extends StatefulWidget {

  @override
  State<TapBarScreen> createState() => _TapBarScreenState();
}

class _TapBarScreenState extends State<TapBarScreen> {
  int currentIndex = 0;


  final List<TabItem> tabItems = [
    TabItem(
      icon: "assets/icons/home.svg",
      label: "home",

    ),
    TabItem(
      icon: "assets/icons/home.svg",
      label: "addTask",

    ),
    TabItem(
      icon:  "assets/icons/home.svg",
      label: "profile",
    ),
    TabItem(
      icon:  "assets/icons/home.svg",
      label: "profile",
    ),
  ];

  @override
  Widget build(BuildContext context) {
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

              margin: EdgeInsets.symmetric(horizontal: 16,vertical: 24),
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
               gradient: AppColor.primaryGradient,
               //  color: AppColor.main,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(tabItems.length, (index) {
                  final tabItem = tabItems[index];
                  return InkWell(
                    onTap: () => setState(() => currentIndex = index),
                    child: Container(
                      alignment: Alignment.center,
                      height: 56,
                      width: currentIndex == index ? 150 : 56,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: currentIndex == index
                              ? AppColor.white
                              : AppColor.main,
                          width: 2,
                        ),
                        color: currentIndex == index
                            ? AppColor.secondary
                            :  AppColor.main,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            tabItem.icon,height: 25,width: 25,
                            color:AppColor.white

                          ),
                          if (currentIndex == index)
                            Text(
                              "  ${tabItem.label}",
                              style: TextStyle(fontSize: 14, color: AppColor.white),
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
