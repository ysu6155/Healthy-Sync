import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/cubit/bmi/bmi_cubit.dart';

class BMICalculatorScreen extends StatelessWidget {
  const BMICalculatorScreen({super.key});

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
      body: Stack(
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
                        activeColor: AppColor.mainPink,
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
                        onAdd: () => cubit.updateWeight(cubit.weight + 0.1),
                        onRemove: () => cubit.updateWeight(cubit.weight - 0.1),
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
              ],
            ),
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
    return _buildCard(
      child: Column(
        children: [
          Text(title, style: _labelStyle()),
          SizedBox(height: 8.h),
          Text(value.toStringAsFixed(0), style: _numberStyle()),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _circleButton(Icons.remove, onRemove),
              _circleButton(Icons.add, onAdd),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onPressed) {
    return CircleAvatar(
      radius: 20.r,
      backgroundColor: AppColor.grey,
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: AppColor.mainBlue.withOpacity(0.8),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: child,
    );
  }

  TextStyle _labelStyle() => TextStyle(
        color: AppColor.mainPink,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle _numberStyle() => TextStyle(
        fontSize: 36.sp,
        fontWeight: FontWeight.bold,
        color: AppColor.white,
      );
}
