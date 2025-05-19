import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/shows.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/cubit/woman_cycle_cubit.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/cubit/woman_cycle_state.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/screens/woman_cycle/screens/settings_screen.dart';

class WomanCycleScreen extends StatefulWidget {
  const WomanCycleScreen({super.key});

  @override
  State<WomanCycleScreen> createState() => _WomanCycleScreenState();
}

class _WomanCycleScreenState extends State<WomanCycleScreen> {
  DateTime? startDate;
  int selectedDayIndex = 0;
  List<DateTime> cycleHistory = [];

  @override
  void initState() {
    super.initState();
    _loadCycleHistory();
  }

  Future<void> _loadCycleHistory() async {
    final history =
        await SharedHelper.get(SharedKeys.cycleHistory) as List<String>? ?? [];
    setState(() {
      cycleHistory = history.map((date) => DateTime.parse(date)).toList();
      if (cycleHistory.isNotEmpty) {
        startDate = cycleHistory.last;
      }
    });
  }

  List<DateTime> generateCycleDays() {
    if (startDate == null) return [];
    final cycleLength =
        context.read<WomanCycleCubit>().state is WomanCycleLoaded
            ? (context.read<WomanCycleCubit>().state as WomanCycleLoaded)
                    .settings['cycleLength'] ??
                28
            : 28;
    return List.generate(
      cycleLength,
      (index) => startDate!.add(Duration(days: index)),
    );
  }

  Color getDayColor(int index) {
    final state = context.read<WomanCycleCubit>().state;
    if (state is! WomanCycleLoaded) return Colors.grey[300]!;

    final periodLength = state.settings['periodLength'] ?? 5;
    final ovulationDay = state.settings['ovulationDay'] ?? 14;
    final ovulationLength = state.settings['ovulationLength'] ?? 5;
    final cycleLength = state.settings['cycleLength'] ?? 28;

    if (index < periodLength) return Colors.pink[200]!;
    if (index == ovulationDay) return Colors.amberAccent;
    if (index >= ovulationDay - ovulationLength + 2 &&
        index <= ovulationDay + 1) {
      return Colors.lightGreen;
    }
    if (index >= cycleLength - 5) return Colors.deepOrangeAccent;
    return Colors.grey[300]!;
  }

  List<DateTime> get cycleDays => generateCycleDays();

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;
  }

  String _getDayType(int index) {
    final state = context.read<WomanCycleCubit>().state;
    if (state is! WomanCycleLoaded) return '';

    final periodLength = state.settings['periodLength'] ?? 5;
    final ovulationDay = state.settings['ovulationDay'] ?? 14;
    final cycleLength = state.settings['cycleLength'] ?? 28;

    if (index < periodLength) return 'فترة الدورة';
    if (index == ovulationDay) return 'أفضل يوم تبويض';
    if (index >= ovulationDay - 3 && index <= ovulationDay + 1)
      return 'فترة التبويض';
    if (index >= cycleLength - 5) return 'قبل الدورة';
    return 'يوم عادي';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WomanCycleCubit, WomanCycleState>(
      builder: (context, state) {
        if (state is WomanCycleLoading) {
          return showLoading();
        }

        final today = DateTime.now();
        final days = cycleDays;
        final selectedDate = (days.isNotEmpty) ? days[selectedDayIndex] : today;
        final nextCycleDate = (startDate != null && state is WomanCycleLoaded)
            ? startDate!
                .add(Duration(days: state.settings['cycleLength'] ?? 28))
            : null;
        final radius = 140.0;
        final dotSize = 25.0;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.mainPink,
            title: Text(
              "الدورة الشهرية",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.history),
                onPressed: () => _showHistoryDialog(context),
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()),
                  );
                  context.read<WomanCycleCubit>().loadSettings();
                },
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              20.H,
              const WomanCycleTips(),
              20.H,
              if (nextCycleDate != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "الدورة القادمة: ${DateFormat('d MMMM', 'ar').format(nextCycleDate)} / ",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    3.W,
                    Text(
                      "الدورة الحالية: ${DateFormat('d MMMM', 'ar').format(startDate!)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              if (startDate == null)
                Text(
                  " لا توجد دوره مسجله",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              10.H,
              Center(
                child: SizedBox(
                  width: 2 * radius + dotSize,
                  height: 2 * radius + dotSize,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PositionedDirectional(
                        top: radius / 2,
                        child: Column(
                          children: [
                            Container(
                              width: dotSize * 3.7.sp,
                              height: dotSize * 3.2.sp,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: getDayColor(selectedDayIndex),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.pink.withOpacity(0.4),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      DateFormat('d MMMM', 'ar')
                                          .format(selectedDate),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    if (startDate != null)
                                      Text(
                                        _getDayType(selectedDayIndex),
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            20.H,
                            CustomButton(
                              width: 100.sp,
                              textStyle: TextStyle(
                                fontSize: 16.sp,
                                color: AppColor.white,
                                fontWeight: FontWeight.bold,
                              ),
                              onTap: registerNewCycleFromSelected,
                              name: "تسجيل دوره",
                            ),
                          ],
                        ),
                      ),
                      ...List.generate(days.length, (index) {
                        final angle = (2 * pi * index) / days.length;
                        final offsetX = radius * cos(angle);
                        final offsetY = radius * sin(angle);
                        final isSelected = index == selectedDayIndex;
                        final isCurrentDay = isToday(days[index]);

                        return Positioned(
                          left: offsetX + radius,
                          top: offsetY + radius,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDayIndex = index;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: dotSize,
                              height: dotSize,
                              decoration: BoxDecoration(
                                color: getDayColor(index),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColor.mainBlue
                                      : isCurrentDay
                                          ? AppColor.mainBlueDark
                                          : Colors.transparent,
                                  width: (isSelected || isCurrentDay) ? 3 : 0,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              15.H,
              _buildLegend(),
              20.H,
            ],
          ),
        );
      },
    );
  }

  void registerNewCycleFromSelected() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 90)),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      helpText: 'اختر تاريخ بداية الدورة',
      locale: const Locale('ar'),
    );

    if (pickedDate != null) {
      if (startDate == null) {
        _showPeriodLengthDialog(pickedDate);
      } else {
        setState(() {
          startDate = pickedDate;
          cycleHistory.add(startDate!);
          selectedDayIndex = 0;
        });

        await SharedHelper.sava(
          SharedKeys.cycleHistory,
          cycleHistory.map((date) => date.toIso8601String()).toList(),
        );

        showSuccessSnackBar("تم تسجيل بداية دورة بنجاح", context);
      }
    }
  }

  void _showPeriodLengthDialog(DateTime selected) {
    final state = context.read<WomanCycleCubit>().state;
    if (state is! WomanCycleLoaded) return;

    final controller = TextEditingController(
      text: (state.settings['periodLength'] ?? 5).toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("تسجيل دورة جديدة"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "مدة نزول الدم (أيام)"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء"),
            ),
            TextButton(
              onPressed: () async {
                final entered = int.tryParse(controller.text);
                if (entered != null && entered > 0) {
                  await SharedHelper.sava(SharedKeys.periodLength, entered);
                  setState(() {
                    startDate = selected;
                    cycleHistory.add(startDate!);
                    selectedDayIndex = 0;
                  });

                  await SharedHelper.sava(
                    SharedKeys.cycleHistory,
                    cycleHistory.map((date) => date.toIso8601String()).toList(),
                  );

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "تم تسجيل بداية دورة جديدة بتاريخ ${DateFormat('d MMMM', 'ar').format(startDate!)}",
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text("تسجيل"),
            ),
          ],
        );
      },
    );
  }

  void _showHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("سجل الدورات"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: cycleHistory.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.date_range),
                title: Text(
                  DateFormat('d MMMM yyyy', 'ar').format(cycleHistory[index]),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("إغلاق"),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        children: [
          _legendItem(Colors.pink[200]!, "فترة الدورة"),
          _legendItem(Colors.lightGreen, "فترة التبويض"),
          _legendItem(Colors.amberAccent, "أفضل يوم تبويض"),
          _legendItem(Colors.deepOrangeAccent, "قبل الدورة"),
          _legendItem(Colors.grey[200]!, "يوم عادي"),
          _legendItem(AppColor.mainBlue, "التاريخ المحدد"),
          _legendItem(AppColor.mainBlueDark, "تاريخ اليوم "),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12.sp,
          height: 12.sp,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        6.W,
        Text(label, style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }
}
