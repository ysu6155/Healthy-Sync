import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/woman_cycle/cubit/woman_cycle_cubit.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/woman_cycle/cubit/woman_cycle_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WomanCycleCubit, WomanCycleState>(
      builder: (context, state) {
        if (state is WomanCycleLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is WomanCycleError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WomanCycleCubit>().loadSettings();
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is! WomanCycleLoaded) {
          return const Scaffold(
            body: Center(
              child: Text('حدث خطأ غير متوقع'),
            ),
          );
        }

        final settings = state.settings;
        final cycleLengthController = TextEditingController(
          text: settings['cycleLength'].toString(),
        );
        final periodLengthController = TextEditingController(
          text: settings['periodLength'].toString(),
        );
        final ovulationLengthController = TextEditingController(
          text: settings['ovulationLength'].toString(),
        );

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.mainPink,
            title: const Text(
              "إعدادات الدورة الشهرية",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مدة الدورة الشهرية',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                8.H,
                TextField(
                  controller: cycleLengthController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'عدد أيام الدورة الشهرية',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                16.H,
                Text(
                  'مدة نزول الدم',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                8.H,
                TextField(
                  controller: periodLengthController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'عدد أيام نزول الدم',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                16.H,
                Text(
                  'مدة التبويض',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                8.H,
                TextField(
                  controller: ovulationLengthController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'عدد أيام التبويض',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                24.H,
                Center(
                  child: CustomButton(
                    width: 200.w,
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                    ),
                    onTap: () {
                      final cycleLength =
                          int.tryParse(cycleLengthController.text);
                      final periodLength =
                          int.tryParse(periodLengthController.text);
                      final ovulationLength =
                          int.tryParse(ovulationLengthController.text);

                      if (cycleLength != null &&
                          periodLength != null &&
                          ovulationLength != null) {
                        context.read<WomanCycleCubit>().updateSettings(
                              cycleLength: cycleLength,
                              periodLength: periodLength,
                              ovulationLength: ovulationLength,
                            );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('الرجاء إدخال قيم صحيحة'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    name: "حفظ الإعدادات",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
