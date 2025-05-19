import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/helpers/extensions.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/shows.dart';
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

  // Load the settings from SharedPreferences
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
        index <= ovulationDay + 1) return Colors.lightGreen; // فترة التبويض

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
          "الدورة الشهرية",
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
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              context.push(SettingsScreen());

              await loadSettings();
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          20.H,
          WomanCycleTips(),
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
                                  DateFormat(
                                    'd MMMM',
                                    'ar',
                                  ).format(selectedDate),
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
        // أول مرة: نسأله عن مدة الدورة
        _showPeriodLengthDialog(pickedDate);
      } else {
        // بعد أول مرة: نسجل مباشرة
        setState(() {
          startDate = pickedDate;
          cycleHistory.add(startDate!);
          selectedDayIndex = 0;
        });

        showSuccessSnackBar("تم تسجيل بداية دورة بنجاح", context);
      }
    }
  }

  void _showPeriodLengthDialog(DateTime selected) {
    final controller = TextEditingController(text: periodLength.toString());
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

  String _getDayType(int index) {
    if (index < periodLength) return 'فترة الدورة';
    if (index == ovulationDay) return 'أفضل يوم تبويض';
    if (index >= ovulationDay - 3 && index <= ovulationDay + 1)
      return 'فترة التبويض';
    if (index >= cycleLength - 5) return 'قبل الدورة';
    return 'يوم عادي';
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
                  DateFormat(
                    'd MMMM yyyy',
                    'ar',
                  ).format(cycleHistory[index]),
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

class WomanCycleTips extends StatefulWidget {
  const WomanCycleTips({super.key});

  @override
  State<WomanCycleTips> createState() => _WomanCycleTipsState();
}

class _WomanCycleTipsState extends State<WomanCycleTips> {
  int currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final List<String> tips = [
    "احرصي على شرب الماء بكثرة خلال الدورة",
    "تجنبي المشروبات الباردة لتقليل التقلصات",
    "مارسي التمارين الخفيفة لتحسين الدورة الدموية",
    "تناولي أطعمة غنية بالحديد لتعويض الدم المفقود",
    "خدي قسطًا كافيًا من الراحة والنوم",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: tips.length,
          itemBuilder: (context, index, pageIndex) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColor.mainPink.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColor.mainPink, width: 1),
              ),
              child: Center(
                child: Text(
                  tips[index],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.mainPink,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 160.sp,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.85,
            autoPlayInterval: const Duration(seconds: 5),
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: 10.sp),
        AnimatedSmoothIndicator(
          activeIndex: currentIndex,
          count: tips.length,
          effect: ExpandingDotsEffect(
            activeDotColor: AppColor.mainPink,
            dotColor: AppColor.grey.withOpacity(0.5),
            dotHeight: 10.sp,
            dotWidth: 15.sp,
            spacing: 6.sp,
          ),
          onDotClicked: (index) => _carouselController.animateToPage(index),
        ),
      ],
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _cycleController;
  late TextEditingController _periodController;
  late TextEditingController _ovulationController;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<CycleProvider>(context, listen: false);
    _cycleController =
        TextEditingController(text: provider.cycleLength.toString());
    _periodController =
        TextEditingController(text: provider.periodLength.toString());
    _ovulationController =
        TextEditingController(text: provider.ovulationLength.toString());
  }

  @override
  void dispose() {
    _cycleController.dispose();
    _periodController.dispose();
    _ovulationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإعدادات'),
        centerTitle: true,
        backgroundColor: AppColor.mainPink,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0).w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNumberField(
              label: "مدة الدورة (أيام)",
              controller: _cycleController,
            ),
            15.verticalSpace,
            _buildNumberField(
              label: "مدة النزيف (أيام)",
              controller: _periodController,
            ),
            15.verticalSpace,
            _buildNumberField(
              label: "مدة التبويض (أيام)",
              controller: _ovulationController,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final cycle = int.tryParse(_cycleController.text) ?? 28;
                  final period = int.tryParse(_periodController.text) ?? 7;
                  final ovulation =
                      int.tryParse(_ovulationController.text) ?? 5;

                  if (cycle > 0 && period > 0 && ovulation > 0) {
                    final provider =
                        Provider.of<CycleProvider>(context, listen: false);
                    await provider.updateSettings(
                      cycleLength: cycle,
                      periodLength: period,
                      ovulationLength: ovulation,
                    );
                    Navigator.pop(context);
                    showSuccessSnackBar("تم حفظ الإعدادات بنجاح", context);
                  } else {
                    showErrorSnackBar("الرجاء إدخال قيم صحيحة", context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400],
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                child: Text(
                  "حفظ التعديلات",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberField({
    required String label,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class CycleProvider extends ChangeNotifier {
  DateTime? _startDate;
  int _cycleLength = 28;
  int _periodLength = 7;
  int _ovulationDay = 14;
  int _ovulationLength = 5;
  List<DateTime> _cycleHistory = [];

  DateTime? get startDate => _startDate;
  int get cycleLength => _cycleLength;
  int get periodLength => _periodLength;
  int get ovulationDay => _ovulationDay;
  int get ovulationLength => _ovulationLength;
  List<DateTime> get cycleHistory => _cycleHistory;

  CycleProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _cycleLength = await SharedHelper.get(SharedKeys.cycleLength) as int? ?? 28;
    _periodLength =
        await SharedHelper.get(SharedKeys.periodLength) as int? ?? 7;
    _ovulationDay =
        await SharedHelper.get(SharedKeys.ovulationDay) as int? ?? 14;
    _ovulationLength =
        await SharedHelper.get(SharedKeys.ovulationLength) as int? ?? 5;
    notifyListeners();
  }

  Future<void> updateSettings({
    required int cycleLength,
    required int periodLength,
    required int ovulationLength,
  }) async {
    _cycleLength = cycleLength;
    _periodLength = periodLength;
    _ovulationLength = ovulationLength;

    await SharedHelper.sava(SharedKeys.cycleLength, cycleLength);
    await SharedHelper.sava(SharedKeys.periodLength, periodLength);
    await SharedHelper.sava(SharedKeys.ovulationLength, ovulationLength);

    notifyListeners();
  }

  void setStartDate(DateTime date) {
    _startDate = date;
    _cycleHistory.add(date);
    notifyListeners();
  }

  List<DateTime> generateCycleDays() {
    if (_startDate == null) return [];
    return List.generate(
      _ovulationDay + 3,
      (index) => _startDate!.add(Duration(days: index)),
    );
  }

  Color getDayColor(int index) {
    if (index < _periodLength) return Colors.pink[200]!;
    if (index == _ovulationDay) return Colors.amberAccent;
    if (index >= _ovulationDay - _ovulationLength + 2 &&
        index <= _ovulationDay + 1) return Colors.lightGreen;
    if (index >= _cycleLength - 5) return Colors.deepOrangeAccent;
    return Colors.grey[300]!;
  }

  String getDayType(int index) {
    if (index < _periodLength) return 'فترة الدورة';
    if (index == _ovulationDay) return 'أفضل يوم تبويض';
    if (index >= _ovulationDay - 3 && index <= _ovulationDay + 1)
      return 'فترة التبويض';
    if (index >= _cycleLength - 5) return 'قبل الدورة';
    return 'يوم عادي';
  }
}
