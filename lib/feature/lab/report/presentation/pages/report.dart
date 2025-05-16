import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  DateTimeRange? selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('التقارير والإحصائيات'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CustomButton(
                onTap: () async {
                  final DateTimeRange? picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDateRange = picked;
                    });
                  }
                },
                name: selectedDateRange == null
                    ? 'اختر الفترة الزمنية'
                    : '${selectedDateRange!.start.toLocal()} - ${selectedDateRange!.end.toLocal()}'),
            SizedBox(height: 20),
            _buildStatCard('عدد التحاليل المنفذة', '245'),
            _buildStatCard('عدد الوصفات المصروفة', '180'),
            SizedBox(height: 20),
            Text('أكثر الأدوية طلبًا:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildTopList(['بانادول', 'أوجمنتين', 'فيتامين C']),
            SizedBox(height: 20),
            Text('أكثر التحاليل المطلوبة:',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            _buildTopList(['CBC', 'سكر صايم', 'وظائف كبد']),
            SizedBox(height: 30.h),
            Text('توزيع أنواع التحاليل:',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                        value: 40, title: 'CBC', color: Colors.blue),
                    PieChartSectionData(
                        value: 30, title: 'سكر', color: Colors.green),
                    PieChartSectionData(
                        value: 30, title: 'كبد', color: Colors.orange),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Text('عدد الطلبات خلال الشهر:',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(toY: 10, color: Colors.blue)
                    ]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(toY: 15, color: Colors.green)
                    ]),
                    BarChartGroupData(x: 3, barRods: [
                      BarChartRodData(toY: 8, color: Colors.orange)
                    ]),
                    BarChartGroupData(
                        x: 4,
                        barRods: [BarChartRodData(toY: 12, color: Colors.red)]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String count) {
    return Card(
      color: AppColor.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10.sp),
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 18.sp)),
        trailing: Text(count,
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildTopList(List<String> items) {
    return Column(
      children: items
          .asMap()
          .entries
          .map((entry) => ListTile(
                leading: CircleAvatar(
                    backgroundColor: AppColor.mainBlue,
                    child: Text('${entry.key + 1}',
                        style: TextStyle(color: AppColor.white))),
                title: Text(entry.value),
              ))
          .toList(),
    );
  }
}
