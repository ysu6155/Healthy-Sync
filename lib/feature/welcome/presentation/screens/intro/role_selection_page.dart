import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/constants/app_assets.dart';
import 'package:healthy_sync/core/constants/enum.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:healthy_sync/feature/authentication/presentation/screens/login/login_screen.dart';

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
            start: ResponsiveHelper.isMobile(context)
                ? 0.sp
                : MediaQuery.of(context).size.width / 5,
            child: Image.asset(
              AppAssets.welcome,
              width: ResponsiveHelper.isMobile(context) ? 1.sw : 1.sw - 150.sp,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height:
                  ResponsiveHelper.isMobile(context) ? 1.sh / 2.1 : 1.sh / 1.8,
              padding: const EdgeInsets.only(left: 35, right: 35, top: 35),
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
                        LocaleKeys.whoAreYou.tr(),
                        style: TextStyle(
                          fontSize: ResponsiveHelper.isMobile(context)
                              ? 40.sp
                              : 30.sp,
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      4.W,
                      Text(
                        LocaleKeys.Q.tr(),
                        style: TextStyle(
                          fontSize: ResponsiveHelper.isMobile(context)
                              ? 40.sp
                              : 30.sp,
                          color: AppColor.mainPink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ResponsiveHelper.isMobile(context) ? 30.H : 20.H,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                    create: (context) => LoginCubit(),
                                    child:
                                        LoginScreen(userType: selectedType!))));
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
            top: ResponsiveHelper.isMobile(context) ? 330.sp : 180.sp,
            end: 30.sp,
            child: Transform(
              alignment: Alignment.center,
              transform: context.locale.languageCode == 'en'
                  ? Matrix4.rotationY(3.1416)
                  : Matrix4.rotationY(0),
              child: Image.asset(
                AppAssets.syringe,
                width: 106.sp,
                height: 106.sp,
                fit: BoxFit.cover,
              ),
            ),
          ),
          PositionedDirectional(
            top: ResponsiveHelper.isMobile(context) ? 310.sp : 160.sp,
            start: 10.sp,
            child: Transform(
              alignment: Alignment.center,
              transform: context.locale.languageCode == 'en'
                  ? Matrix4.rotationY(3.1416)
                  : Matrix4.rotationY(0),
              child: Image.asset(
                AppAssets.syringe2,
                width: 140.sp,
                height: 140.sp,
                fit: BoxFit.cover,
              ),
            ),
          ),
          PositionedDirectional(
            start: context.locale.languageCode == 'ar'
                ? 10.sp
                : MediaQuery.of(context).size.width - 50.sp,
            top: 10.sp,
            child: GestureDetector(
              onTap: () {
                widget.carouselController.animateToPage(0);
              },
              child: Transform(
                alignment: Alignment.center,
                transform: context.locale.languageCode == 'en'
                    ? Matrix4.rotationY(6)
                    : Matrix4.rotationY(0),
                child: Image.asset(
                  AppAssets.button,
                  height: 43.sp,
                  width: 43.w,
                  fit: BoxFit.cover,
                ),
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
