import 'package:flutter/material.dart';
import 'package:healthy_sync/core/utils/app_assets.dart';
import 'package:healthy_sync/core/utils/app_color.dart';

final List<Map<String, dynamic>> tests = [
  for (int i = 0; i < 5; i++) ...[
    {
      'name': 'CBC',
      'icon': Icons.bloodtype,
      'desc': 'Complete Blood Count',
      'details':
          'Measures red and white blood cells, hemoglobin, and platelets.',
      'image': AppAssets.image1,
      'values': {
        'WBC': '${(5.0 + i * 0.2).toStringAsFixed(1)} x10^9/L',
        'RBC': '${(4.5 + i * 0.1).toStringAsFixed(1)} x10^12/L',
        'Hemoglobin': '${(13.5 + i * 0.3).toStringAsFixed(1)} g/dL',
        'Platelets': '${(240 + i * 5)} x10^9/L',
      },
      'dateTime': DateTime(2025, 3, 10 - i),
      'status':
          i % 3 == 0
              ? 'Completed'
              : i % 3 == 1
              ? 'Pending Results'
              : 'Retest Needed',
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
      'name': 'ESR',
      'icon': Icons.speed,
      'desc': 'Erythrocyte Sedimentation Rate',
      'details': 'Checks inflammation levels in the body.',
      'image': AppAssets.image1,
      'values': {'ESR': '${(15 + i * 2)} mm/hr'},
      'dateTime': DateTime(2025, 3, 8 - i),
      'status': i % 2 == 0 ? 'Completed' : 'Pending Results',
      'color': i % 2 == 0 ? AppColor.green : AppColor.red,
    },
  ],

  for (int i = 0; i < 4; i++) ...[
    {
      'name': 'Blood Glucose',
      'icon': Icons.monitor_heart,
      'desc': 'Fasting & Random',
      'details': 'Measures blood sugar levels to monitor diabetes.',
      'image': AppAssets.image1,
      'values': {
        'Fasting': '${(80 + i * 5)} mg/dL',
        'Post Meal': '${(120 + i * 10)} mg/dL',
      },
      'dateTime': DateTime(2025, 3, 7 - i),
      'status': i % 3 == 0 ? 'Completed' : 'Scheduled',
      'color': i % 3 == 0 ? AppColor.green : AppColor.yellow,
    },
  ],

  for (int i = 0; i < 7; i++) ...[
    {
      'name': 'Lipid Profile',
      'icon': Icons.favorite,
      'desc': 'Cholesterol & Triglycerides',
      'details': 'Assesses heart disease risk by measuring lipid levels.',
      'image': AppAssets.image1,
      'values': {
        'Total Cholesterol': '${(170 + i * 5)} mg/dL',
        'LDL': '${(95 + i * 3)} mg/dL',
        'HDL': '${(45 + i * 2)} mg/dL',
        'Triglycerides': '${(110 + i * 5)} mg/dL',
      },
      'dateTime': DateTime(2025, 3, 6 - i),
      'status': i % 2 == 0 ? 'Completed' : 'Retest Needed',
      'color': i % 2 == 0 ? AppColor.green : AppColor.red,
    },
  ],
];
