import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/widgets/custom_button.dart';
import 'package:healthy_sync/core/widgets/custom_text_field.dart';

class DrugInfoScreen extends StatefulWidget {
  const DrugInfoScreen({super.key});

  @override
  _DrugInfoScreenState createState() => _DrugInfoScreenState();
}

class _DrugInfoScreenState extends State<DrugInfoScreen> {
  final TextEditingController _controller = TextEditingController();
  final Dio dio = Dio();
  Map<String, dynamic>? drugData;
  bool isLoading = false;

  Future<void> fetchDrugInfo(String drugName) async {
    if (drugName.isEmpty) {
      _showError("الرجاء إدخال اسم الدواء");
      return;
    }

    setState(() {
      isLoading = true;
      drugData = null;
    });

    const String apiUrl =
        "https://drug-info-and-price-history.p.rapidapi.com/1/druginfo";
    const String apiKey = "978c027bdemsh368d1693158640bp16fcbcjsn471593012df4";

    try {
      final response = await dio.get(
        apiUrl,
        queryParameters: {"drug": drugName},
        options: Options(
          headers: {
            "x-rapidapi-key": apiKey,
            "x-rapidapi-host": "drug-info-and-price-history.p.rapidapi.com",
          },
        ),
      );

      if (response.data is List && response.data.isNotEmpty) {
        setState(() {
          drugData = response.data[0];
        });

        // Debug log to see the structure of the response
        print("API Response: ${response.data[0]}");

        // Check if openfda exists
        if (drugData != null) {
          print("openfda: ${drugData!["openfda"]}");

          // Check pharmaceutical classification fields
          final openfda = drugData!["openfda"] as Map<String, dynamic>?;
          if (openfda != null) {
            print("pharm_class_moa: ${openfda["pharm_class_moa"]}");
            print("pharm_class_cs: ${openfda["pharm_class_cs"]}");
            print("pharm_class_epc: ${openfda["pharm_class_epc"]}");
          } else {
            print("openfda is null");
          }
        }
      } else {
        _showError("لم يتم العثور على بيانات.");
      }
    } on DioException catch (e) {
      print("🔴 DioException: ${e.response?.data}");

      // Check for specific error messages
      if (e.response?.data.toString().contains("No drug found") == true) {
        _showError(
            "لم يتم العثور على دواء بهذا الاسم. يرجى التحقق من الاسم أو تجربة اسم آخر.");
      } else {
        _showError("خطأ في الاتصال بالخادم: ${e.message}");
      }
    } catch (e) {
      print("⚠️ Unexpected Error: $e");
      _showError("حدث خطأ غير متوقع.");
    }

    setState(() {
      isLoading = false;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'حسناً',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: Text(
          'معلومات الدواء',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        //backgroundColor: Colors.grey[200],
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                _buildSearchSection(),
                SizedBox(height: 20.h),
                _buildDrugInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Card(
      color: AppColor.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'البحث عن دواء',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15.h),
            CustomTextField(
              controller: _controller,
              labelText: 'اسم الدواء',
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
              hintText: 'أدخل اسم الدواء',
            ),
            SizedBox(height: 15.h),
            CustomButton(
              name: 'استعراض البيانات',
              onTap: () {
                fetchDrugInfo(_controller.text);
              },
              backgroundColor: AppColor.mainBlue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrugInfo() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColor.mainBlue,
        ),
      );
    }

    if (drugData == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.medication_outlined,
              size: 80.sp,
              color: Colors.grey[400],
            ),
            SizedBox(height: 20.h),
            Text(
              "لم يتم العثور على بيانات",
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    // Safely extract data with null checks
    final brandName = _getStringValue(drugData, "brand_name");
    final genericName = _getStringValue(drugData, "generic_name");
    final labelerName = _getStringValue(drugData, "labeler_name");
    //final packaging = _getStringValue(drugData, "packaging");
    final marketingStartDate =
        _getStringValue(drugData, "marketing_start_date");
    final listingExpirationDate =
        _getStringValue(drugData, "listing_expiration_date");
    final marketingCategory = _getStringValue(drugData, "marketing_category");
    final dosageForm = _getStringValue(drugData, "dosage_form");
    final productType = _getStringValue(drugData, "product_type");
    final route = _getStringValue(drugData, "route");
    final productNdc = _getStringValue(drugData, "product_ndc");

    // Extract pharmaceutical classification values
    String pharmClassMoa = "غير متوفر";
    String pharmClassCs = "غير متوفر";
    String pharmClassEpc = "غير متوفر";

    try {
      // Get openfda object
      final openfda = drugData?["openfda"] as Map<String, dynamic>?;
      print("openfda in build: $openfda");

      if (openfda != null) {
        // Get pharm_class_moa
        final moaList = openfda["pharm_class_moa"] as List?;
        print("moaList: $moaList");
        if (moaList != null && moaList.isNotEmpty) {
          pharmClassMoa = moaList[0].toString().replaceAll(" [MoA]", "");
          print("pharmClassMoa: $pharmClassMoa");
        }

        // Get pharm_class_cs
        final csList = openfda["pharm_class_cs"] as List?;
        print("csList: $csList");
        if (csList != null && csList.isNotEmpty) {
          pharmClassCs = csList[0].toString().replaceAll(" [CS]", "");
          print("pharmClassCs: $pharmClassCs");
        }

        // Get pharm_class_epc
        final epcList = openfda["pharm_class_epc"] as List?;
        print("epcList: $epcList");
        if (epcList != null && epcList.isNotEmpty) {
          pharmClassEpc = epcList[0].toString().replaceAll(" [EPC]", "");
          print("pharmClassEpc: $pharmClassEpc");
        }
      } else {
        print("openfda is null in build");
      }
    } catch (e) {
      print("Error processing pharmaceutical classifications: $e");
    }

    // Safely extract active ingredients
    String activeIngredients = "غير متوفر";
    String strength = "غير متوفر";

    try {
      final ingredients = drugData?["active_ingredients"] as List?;
      if (ingredients != null && ingredients.isNotEmpty) {
        activeIngredients = ingredients
            .map((e) => e["name"] as String? ?? "")
            .where((s) => s.isNotEmpty)
            .join(", ");
        strength = ingredients
            .map((e) => e["strength"] as String? ?? "")
            .where((s) => s.isNotEmpty)
            .join(", ");
      }
    } catch (e) {
      print("Error processing active ingredients: $e");
    }

    return Card(
      color: AppColor.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            _buildInfoHeader(),
            SizedBox(height: 20.h),
            _buildInfoItem(
              icon: Icons.medication,
              title: "اسم الدواء",
              value: brandName,
            ),
            SizedBox(height: 15.h),
            _buildInfoItem(
              icon: Icons.science,
              title: "الاسم العلمي",
              value: genericName,
            ),
            SizedBox(height: 15.h),
            _buildInfoItem(
              icon: Icons.business,
              title: "الشركة المصنعة",
              value: labelerName,
            ),
            SizedBox(height: 15.h),
            _buildInfoItem(
              icon: Icons.science,
              title: "المادة الفعالة",
              value: activeIngredients,
            ),
            SizedBox(height: 15.h),
            _buildInfoItem(
              icon: Icons.medical_services,
              title: "الجرعة",
              value: strength,
            ),
            // SizedBox(height: 15.h),
            // _buildInfoItem(
            //   icon: Icons.inventory,
            //   title: "التغليف",
            //   value: packaging,
            // ),
            SizedBox(height: 15.h),
            _buildInfoItem(
              icon: Icons.calendar_today,
              title: "تاريخ التسويق",
              value: marketingStartDate,
            ),
            SizedBox(height: 15.h),
            _buildInfoItem(
              icon: Icons.event_busy,
              title: "تاريخ انتهاء الصلاحية",
              value: listingExpirationDate,
            ),
            SizedBox(height: 15.h),
            _buildInfoItem(
              icon: Icons.category,
              title: "نوع التسويق",
              value: marketingCategory,
            ),
            SizedBox(height: 15.h),
            _buildInfoItem(
              icon: Icons.medication_liquid,
              title: "شكل الجرعة",
              value: dosageForm,
            ),
            SizedBox(height: 15.h),
            _buildInfoItem(
              icon: Icons.local_pharmacy,
              title: "نوع المنتج",
              value: productType,
            ),
            SizedBox(height: 15.h),
            _buildInfoItem(
              icon: Icons.route,
              title: "طريقة الإعطاء",
              value: route,
            ),
            SizedBox(height: 15.h),
            _buildInfoItem(
              icon: Icons.qr_code,
              title: "كود تعريف المنتج الوطني",
              value: productNdc,
            ),
            SizedBox(height: 15.h),
            _buildInfoItem(
              icon: Icons.science,
              title: "آلية العمل الدوائية",
              value: pharmClassMoa,
            ),
            SizedBox(height: 15.h),
            _buildInfoItem(
              icon: Icons.medical_services,
              title: "التصنيف الكيميائي",
              value: pharmClassCs,
            ),
            SizedBox(height: 15.h),
            _buildInfoItem(
              icon: Icons.category,
              title: "التصنيف الدوائي",
              value: pharmClassEpc,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoHeader() {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: AppColor.mainBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.medication,
            color: AppColor.mainBlue,
            size: 24.sp,
          ),
          SizedBox(width: 10.w),
          Text(
            "معلومات الدواء",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.mainBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColor.mainBlue, size: 24.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to safely extract string values from the API response
  String _getStringValue(Map<String, dynamic>? data, String key) {
    if (data == null) return "غير متوفر";

    final value = data[key];
    if (value == null) return "غير متوفر";

    if (value is String) return value;
    if (value is List) {
      if (value.isEmpty) return "غير متوفر";
      return value.map((e) => e.toString()).join(", ");
    }

    return value.toString();
  }

 

 
}
