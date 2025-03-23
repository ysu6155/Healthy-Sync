import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/Themes/light_theme.dart';
import 'package:healthy_sync/core/helpers/responsive_helper.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/signup_cubit/signup_cubit.dart';
import 'package:healthy_sync/feature/authentication/presentation/cubit/verification_cubit/cubit/verification_cubit.dart';
import 'package:healthy_sync/feature/chat/presentation/screens/chat_bot_screen.dart';
import 'package:healthy_sync/feature/profile/cubit/profile_cubit.dart';
import 'package:healthy_sync/feature/welcome/presentation/screens/splash/splash_screen.dart';

class HealthySync extends StatelessWidget {
  const HealthySync({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => VerificationCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            theme: themeLight,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: 'Healthy Sync',
            home: child,
          );
        },
        child: ResponsiveHelper.buildResponsiveUI(
          mobile: SplashScreen(),
          tablet: SplashScreen(),
          web: ChatScreen(),
          context: context,
        ),
      ),
    );
  }
}

// صفحه معلومات عن الادويه
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

      log("🔵 API Response: ${response.data[0]}"); // ✅ اطبع البيانات للتأكد

      if (response.data is List && response.data.isNotEmpty) {
        setState(() {
          drugData = response.data[0]; // ✅ استخراج أول عنصر
        });
      } else {
        _showError("لم يتم العثور على بيانات.");
      }
    } on DioException catch (e) {
      print("🔴 DioException: ${e.response?.data}");
      _showError("خطأ في الاتصال بالخادم: ${e.message}");
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
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("معلومات الدواء")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "ادخل اسم الدواء",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  fetchDrugInfo(_controller.text);
                }
              },
              child: const Text("بحث"),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : drugData != null
                ? Expanded(
                  child: ListView(
                    children: [
                      Text(
                        "🔹 اسم الدواء: ${drugData!["brand_name"] ?? "غير متوفر"}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "🏭 الشركة المصنعة: ${drugData!["labeler_name"] ?? "غير متوفر"}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "🧪 المادة الفعالة: ${(drugData!["active_ingredients"] as List?)?.map((e) => e["name"]).join(", ") ?? "غير متوفر"}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "💊 الجرعة: ${(drugData!["active_ingredients"] as List?)?.map((e) => e["strength"]).join(", ") ?? "غير متوفر"}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "📅 تاريخ التسويق: ${drugData!["marketing_start_date"] ?? "غير متوفر"}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
                : const Text("لم يتم العثور على بيانات."),
          ],
        ),
      ),
    );
  }
}
