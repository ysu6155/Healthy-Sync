import 'package:flutter/material.dart';
import 'package:healthy_sync/core/themes/app_color.dart';

final List<Map<String, dynamic>> tests = [
  for (int i = 0; i < 5; i++) ...[
    {
      'name': 'صورة دم كاملة',
      'icon': Icons.bloodtype,
      'desc': 'تحليل مكونات الدم',
      'details':
          'يقيس خلايا الدم الحمراء والبيضاء والهيموغلوبين والصفائح الدموية.',
      'image':
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      'values': {
        'كريات بيضاء': '${(5.0 + i * 0.2).toStringAsFixed(1)} ×10^9/لتر',
        'كريات حمراء': '${(4.5 + i * 0.1).toStringAsFixed(1)} ×10^12/لتر',
        'هيموغلوبين': '${(13.5 + i * 0.3).toStringAsFixed(1)} جم/د.ل',
        'صفائح دموية': '${(240 + i * 5)} ×10^9/لتر',
      },
      'dateTime': DateTime(2025, 3, 10 - i),
      'status':
          i % 3 == 0
              ? 'مكتمل'
              : i % 3 == 1
              ? 'في انتظار النتائج'
              : 'مطلوب إعادة',
      'color':
          i % 3 == 0
              ? AppColor.green
              : i % 3 == 1
              ? AppColor.orange
              : AppColor.red,
    },
  ],

  for (int i = 0; i < 5; i++) ...[
    {
      'name': 'تحليل ESR',
      'icon': Icons.speed,
      'desc': 'معدل ترسيب كرات الدم الحمراء',
      'details': 'يقيس مستوى الالتهابات في الجسم.',
      'image':
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      'values': {'ESR': '${(15 + i * 2)} مم/ساعة'},
      'dateTime': DateTime(2025, 3, 8 - i),
      'status': i % 2 == 0 ? 'مكتمل' : 'في انتظار النتائج',
      'color': i % 2 == 0 ? AppColor.green : AppColor.red,
    },
  ],

  for (int i = 0; i < 4; i++) ...[
    {
      'name': 'تحليل سكر الدم',
      'icon': Icons.monitor_heart,
      'desc': 'صائم وفاطر',
      'details': 'يقيس مستويات السكر في الدم لمتابعة مرض السكري.',
      'image':
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      'values': {
        'صائم': '${(80 + i * 5)} مجم/د.ل',
        'بعد الأكل': '${(120 + i * 10)} مجم/د.ل',
      },
      'dateTime': DateTime(2025, 3, 7 - i),
      'status': i % 3 == 0 ? 'مكتمل' : 'مجدول',
      'color': i % 3 == 0 ? AppColor.green : AppColor.yellow,
    },
  ],

  for (int i = 0; i < 7; i++) ...[
    {
      'name': 'تحليل دهون الدم',
      'icon': Icons.favorite,
      'desc': 'الكوليسترول والدهون الثلاثية',
      'details': 'يقيم خطر الإصابة بأمراض القلب عن طريق قياس الدهون في الدم.',
      'image':
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      'values': {
        'كوليسترول كلي': '${(170 + i * 5)} مجم/د.ل',
        'LDL': '${(95 + i * 3)} مجم/د.ل',
        'HDL': '${(45 + i * 2)} مجم/د.ل',
        'دهون ثلاثية': '${(110 + i * 5)} مجم/د.ل',
      },
      'dateTime': DateTime(2025, 3, 6 - i),
      'status': i % 2 == 0 ? 'مكتمل' : 'مطلوب إعادة',
      'color': i % 2 == 0 ? AppColor.green : AppColor.red,
    },
  ],
];
List<String> healthTips = [
  "https://makkahnewspaper.com/uploads/images/2020/03/18/1159603.png",
  "https://c2.staticflickr.com/6/5575/31196585576_31e127f8ca_o.png",
  "https://l.top4top.io/p_3383ifjbo1.jpg",
   "https://d.top4top.io/p_3383prbk31.jpg",
];
