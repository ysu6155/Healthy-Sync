import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/translations/locale_keys.g.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/ui_helpers.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/woman_cycle/widget/woman_cycle_tips.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WomanCycleScreen extends StatefulWidget {
  const WomanCycleScreen({super.key});

  @override
  State<WomanCycleScreen> createState() => _WomanCycleScreenState();
}

class _WomanCycleScreenState extends State<WomanCycleScreen> {
  DateTime? startDate;
  int cycleLength = 28;
  int periodLength = 7;
  int ovulationDay = 14;
  int selectedDayIndex = 0;
  List<DateTime> cycleHistory = [];
  int ovulationLength = 5;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final loadedCycleLength =
        await SharedHelper.get(SharedKeys.cycleLength) as int? ?? 28;
    final loadedPeriodLength =
        await SharedHelper.get(SharedKeys.periodLength) as int? ?? 7;
    final loadedOvulationDay =
        await SharedHelper.get(SharedKeys.ovulationDay) as int? ?? 14;
    final int loadedOvulationLength =
        await SharedHelper.get(SharedKeys.ovulationLength) as int? ?? 5;

    setState(() {
      cycleLength = loadedCycleLength;
      periodLength = loadedPeriodLength;
      ovulationDay = loadedOvulationDay;
      ovulationLength = loadedOvulationLength;
    });
  }

  List<DateTime> generateCycleDays() {
    if (startDate == null) return [];
    return List.generate(
      ovulationDay + 3,
      (index) => startDate!.add(Duration(days: index)),
    );
  }

  Color getDayColor(int index) {
    if (index < periodLength) return Colors.pink[200]!;
    if (index == ovulationDay) return Colors.amberAccent;
    if (index >= ovulationDay - ovulationLength + 2 &&
        index <= ovulationDay + 1) return Colors.lightGreen;
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

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final days = cycleDays;
    final selectedDate = (days.isNotEmpty) ? days[selectedDayIndex] : today;
    final nextCycleDate = (startDate != null)
        ? startDate!.add(Duration(days: cycleLength))
        : null;
    final radius = 140.0;
    final dotSize = 25.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainPink,
        title: Text(
          LocaleKeys.menstrualCycle.tr(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => _showHistoryDialog(context),
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
                  "${LocaleKeys.newCycle.tr()}: ${DateFormat('d MMMM', 'ar').format(nextCycleDate)} / ",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                3.W,
                Text(
                  "${LocaleKeys.currentCycle.tr()}: ${DateFormat('d MMMM', 'ar').format(startDate!)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          if (startDate == null)
            Text(
              LocaleKeys.noCycleRegistered.tr(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                          width: 120.sp,
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: registerNewCycleFromSelected,
                          name: LocaleKeys.newCycle.tr(),
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
  }

  void registerNewCycleFromSelected() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 90)),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      helpText: LocaleKeys.selectCycleStartDate.tr(),
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

        showSuccessSnackBar(LocaleKeys.cycleStartDateSaved.tr(), context);
      }
    }
  }

  void _showPeriodLengthDialog(DateTime selected) {
    final controller = TextEditingController(text: periodLength.toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(LocaleKeys.newCycle.tr()),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: LocaleKeys.periodLengthDays.tr(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(LocaleKeys.cancel.tr()),
            ),
            TextButton(
              onPressed: () async {
                final entered = int.tryParse(controller.text);
                SharedHelper.sava(SharedKeys.periodLength, entered);
                if (entered != null && entered > 0) {
                  setState(() {
                    startDate = selected;
                    periodLength = entered;
                    cycleHistory.add(startDate!);
                    selectedDayIndex = 0;
                  });

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "${LocaleKeys.cycleStartDateSaved.tr()} ${DateFormat('d MMMM', 'ar').format(startDate!)}",
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: Text(LocaleKeys.registerNow.tr()),
            ),
          ],
        );
      },
    );
  }

  String _getDayType(int index) {
    if (index < periodLength) return LocaleKeys.periodDay.tr();
    if (index == ovulationDay) return LocaleKeys.bestOvulationDay.tr();
    if (index >= ovulationDay - 3 && index <= ovulationDay + 1) {
      return LocaleKeys.ovulationPeriod.tr();
    }
    if (index >= cycleLength - 5) return LocaleKeys.premenstrualPhase.tr();
    return LocaleKeys.normalDay.tr();
  }

  void _showHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(LocaleKeys.cycleHistory.tr()),
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
            child: Text(LocaleKeys.close.tr()),
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
          _legendItem(Colors.pink[200]!, LocaleKeys.periodDay.tr()),
          _legendItem(Colors.lightGreen, LocaleKeys.ovulationPeriod.tr()),
          _legendItem(Colors.amberAccent, LocaleKeys.bestOvulationDay.tr()),
          _legendItem(
              Colors.deepOrangeAccent, LocaleKeys.premenstrualPhase.tr()),
          _legendItem(Colors.grey[200]!, LocaleKeys.normalDay.tr()),
          _legendItem(AppColor.mainBlue, LocaleKeys.selectedDate.tr()),
          _legendItem(AppColor.mainBlueDark, LocaleKeys.today.tr()),
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
