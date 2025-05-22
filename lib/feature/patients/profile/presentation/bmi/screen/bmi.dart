import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/bmi/cubit/bmi_cubit.dart';

class BMICalculatorScreen extends StatelessWidget {
  const BMICalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BMICalculatorCubit(),
      child: const BMICalculatorView(),
    );
  }
}

class BMICalculatorView extends StatelessWidget {
  const BMICalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BMICalculatorCubit>();
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text(
          LocaleKeys.BMIcalculator.tr(),
          style: TextStyles.font20WhiteBold,
        ),
        iconTheme: IconThemeData(color: AppColor.white, size: 24.sp),
        backgroundColor: AppColor.mainBlue,
        centerTitle: true,
        elevation: 2,
      ),
      body: BlocBuilder<BMICalculatorCubit, BMICalculatorState>(
        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildCard(
                      child: Column(
                        children: [
                          Text(LocaleKeys.height.tr(), style: _labelStyle()),
                          SizedBox(height: 8.h),
                          Text(
                            '${cubit.height.toStringAsFixed(1)} ${LocaleKeys.cm.tr()}',
                            style: _numberStyle(),
                          ),
                          Slider(
                            value: cubit.height,
                            min: 50,
                            max: 220,
                            activeColor: AppColor.mainBlueVaryDark,
                            onChanged: (val) => cubit.updateHeight(val),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildValueCard(
                            title: LocaleKeys.weight.tr(),
                            value: cubit.weight,
                            onAdd: () => cubit.updateWeight(cubit.weight + 1),
                            onRemove: () =>
                                cubit.updateWeight(cubit.weight - 0.1),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildValueCard(
                            title: LocaleKeys.age.tr(),
                            value: cubit.age,
                            onAdd: () => cubit.updateAge(cubit.age + 1),
                            onRemove: () => cubit.updateAge(cubit.age - 1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    CustomButton(
                      name: LocaleKeys.BMIcalculator.tr(),
                      onTap: () {
                        cubit.calculateBMI(cubit.height, cubit.weight);
                      },
                    ),
                    if (state is ShowBMIResult) ...[
                      SizedBox(height: 24.h),
                      _buildBMIResultCard(state),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBMIResultCard(ShowBMIResult state) {
    Color resultColor;
    IconData resultIcon;

    if (state.bmi < 18.5) {
      resultColor = const Color(0xFFFFA726); 
      resultIcon = Icons.trending_down_rounded;
    } else if (state.bmi >= 18.5 && state.bmi < 24.9) {
      resultColor = const Color(0xFF66BB6A); 
      resultIcon = Icons.check_circle_rounded;
    } else if (state.bmi >= 25 && state.bmi < 29.9) {
      resultColor = const Color(0xFFFFA726); 
      resultIcon = Icons.trending_up_rounded;
    } else {
      resultColor = const Color(0xFFEF5350); 
      resultIcon = Icons.warning_rounded;
    }

    return Container(
      padding: EdgeInsets.all(24.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border:
            Border.all(color: resultColor.withValues(alpha: 0.15), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: resultColor.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20.w,
            top: -20.h,
            child: Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    resultColor.withValues(alpha: 0.08),
                    resultColor.withValues(alpha: 0.03),
                  ],
                  stops: const [0.3, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            left: -15.w,
            bottom: -15.h,
            child: Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    resultColor.withValues(alpha: 0.08),
                    resultColor.withValues(alpha: 0.03),
                  ],
                  stops: const [0.3, 1.0],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                      color: resultColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      resultIcon,
                      color: resultColor,
                      size: 28.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    state.bmiCategory,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: resultColor,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: resultColor.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: resultColor.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Text(
                  state.bmi.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E293B),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.all(20.sp),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: resultColor.withValues(alpha: 0.08),
                    width: 1,
                  ),
                ),
                child: Text(
                  state.resultMessage,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: const Color(0xFF475569),
                    height: 1.5,
                    letterSpacing: 0.1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard({
    required String title,
    required num value,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFFF8FAFC), 
            Color(0xFFF1F5F9),
            Color(0xFFE2E8F0), 
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCBD5E0).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -15.w,
            top: -15.h,
            child: Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.grey[200]!.withValues(alpha: 0.2),
                    Colors.grey[200]!.withValues(alpha: 0.05),
                  ],
                  stops: const [0.3, 1.0],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: const Color(0xFF1E293B),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.1,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                value.toStringAsFixed(0),
                style: TextStyle(
                  color: const Color(0xFF1E293B),
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _circleButton(Icons.remove, onRemove),
                  _circleButton(Icons.add, onAdd),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 42.sp,
      height: 42.sp,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[300]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: const Color(0xFF475569), size: 20.sp),
        onPressed: onPressed,
        splashRadius: 22,
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFFF8FAFC), 
            Color(0xFFF1F5F9), 
            Color(0xFFE2E8F0), 
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCBD5E0).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  TextStyle _labelStyle() => TextStyle(
        color: const Color(0xFF1E293B),
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      );

  TextStyle _numberStyle() => TextStyle(
        color: const Color(0xFF1E293B),
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.2,
      );
}
