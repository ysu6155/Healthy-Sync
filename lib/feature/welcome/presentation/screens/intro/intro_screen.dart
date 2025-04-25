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
              buildPage(),
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

  Widget buildPage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Align(
                alignment:
                    context.locale.languageCode == 'ar'
                        ? Alignment.topRight
                        : Alignment.topLeft,
                child: RepaintBoundary(
                  child: SvgPicture.asset(
                    AppAssets.ellipse,
                    height:
                        ResponsiveHelper.isMobile(context) ? 500.sp : 400.sp,
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
                end: 50.sp,
                child: Image.asset(
                  AppAssets.carry,
                  height: 106.sp,
                  width: 106.w,
                  fit: BoxFit.cover,
                ),
              ),
              PositionedDirectional(
                start: 50.sp,
                child: Image.asset(
                  AppAssets.rivet,
                  height: 76.sp,
                  width: 76.w,
                  fit: BoxFit.cover,
                ),
              ),
              PositionedDirectional(
                top: 45.sp,
                child: Image.asset(
                  AppAssets.welcome,
                  width: 1.sw - 60.sp,

                  fit: BoxFit.cover,
                ),
              ),
              PositionedDirectional(
                end: -10.sp,
                top: 200.sp,
                child: Image.asset(
                  AppAssets.syringe1,
                  height: 106.sp,
                  width: 106.w,
                  fit: BoxFit.cover,
                ),
              ),
              PositionedDirectional(
                start: 35.sp,
                top: 320.sp,
                child: Image.asset(
                  AppAssets.tist,
                  height: 95.sp,
                  width: 95.w,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
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
      ),
    );
  }
}

class RoleSelectionPage extends StatefulWidget {
  final CarouselSliderController carouselController;

  const RoleSelectionPage({super.key, required this.carouselController});

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  UserType? selectedType;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.mainBlue,
      child: Stack(
        children: [
          PositionedDirectional(
            top: 20.sp,
            child: Image.asset(
              AppAssets.welcome,
              width: 1.sw,
              fit: BoxFit.cover,
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 1.sh / 2.1,
              padding: EdgeInsets.only(left: 35.sp, right: 35.sp, top: 35.sp),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.r),
                  topRight: Radius.circular(50.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "من انت",
                        style: TextStyle(
                          fontSize: 40.sp,
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      4.W,
                      Text(
                        "؟",
                        style: TextStyle(
                          fontSize: 40.sp,
                          color: AppColor.mainPink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  30.H,
                  Row(
                    children: [
                      Expanded(
                        child: UserTypeCard(
                          image: AppAssets.patient,
                          title: LocaleKeys.patient.tr(),
                          isSelected: selectedType == UserType.patient,
                          onTap: () {
                            setState(() => selectedType = UserType.patient);
                          },
                        ),
                      ),
                      30.W,
                      Expanded(
                        child: UserTypeCard(
                          image: AppAssets.doctor,
                          title: LocaleKeys.doctor.tr(),
                          isSelected: selectedType == UserType.doctor,
                          onTap: () {
                            setState(() => selectedType = UserType.doctor);
                          },
                        ),
                      ),
                    ],
                  ),
                  30.H,
                  CustomButton(
                    width: 1.sw - 144.sp,
                    name: LocaleKeys.next.tr(),
                    onTap: () {
                      if (selectedType != null) {
                        context.push(LoginScreen(userType: selectedType!));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("اختر نوع المستخدم أولاً"),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          PositionedDirectional(
            top: 330.sp,
            end: 30.sp,
            child: Image.asset(
              AppAssets.syringe,
              width: 106.sp,
              height: 106.sp,
              fit: BoxFit.cover,
            ),
          ),
          PositionedDirectional(
            top: 310.sp,
            start: 10.sp,
            child: Image.asset(
              AppAssets.syringe2,
              width: 140.sp,
              height: 140.sp,
              fit: BoxFit.cover,
            ),
          ),
          PositionedDirectional(
            start: 10.sp,
            top: 10.sp,
            child: GestureDetector(
              onTap: () {
                widget.carouselController.animateToPage(0);
              },
              child: Image.asset(
                AppAssets.button,
                height: 43.sp,
                width: 43.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserTypeCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final String image;

  const UserTypeCard({
    super.key,
    required this.image,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 123.sp,
            width: 130.sp,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? AppColor.mainPink : AppColor.transparent,
                width: 1,
              ),
            ),
            child: Image.asset(image),
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20.sp,
                color: AppColor.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
