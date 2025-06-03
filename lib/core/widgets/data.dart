import 'package:flutter/material.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';
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
      'status': i % 3 == 0
          ? 'مكتمل'
          : i % 3 == 1
              ? 'في انتظار النتائج'
              : 'مطلوب إعادة',
      'color': i % 3 == 0
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

final specializations = [
  {'name': 'أمراض القلب', 'icon': Icons.favorite, 'value': 'أخصائي قلب'},
  {
    'name': 'طب الأسنان',
    'icon': Icons.medical_services,
    'value': 'أخصائي أسنان',
  },
  {'name': 'الأمراض الجلدية', 'icon': Icons.face, 'value': 'أخصائي جلدية'},
  {'name': 'طب الأعصاب', 'icon': Icons.psychology, 'value': 'أخصائي أعصاب'},
  {'name': 'طب الأطفال', 'icon': Icons.child_care, 'value': 'أخصائي أطفال'},
  {'name': 'العظام', 'icon': Icons.accessibility, 'value': 'أخصائي عظام'},
  {'name': 'العيون', 'icon': Icons.remove_red_eye, 'value': 'أخصائي عيون'},
  {
    'name': 'النساء والتوليد',
    'icon': Icons.pregnant_woman,
    'value': 'أخصائي نساء وولادة',
  },
  {'name': 'الأمراض الجلدية', 'icon': Icons.face, 'value': 'أخصائي جلدية'},
];
final List<Map<String, dynamic>> doctors = [
  {
    "id": "1",
    "name": "د. أحمد",
    "specialty": "أخصائي قلب",
    "image":
        "https://img.freepik.com/free-photo/businesswoman-short-hair-specialist-frustrated-touching_1134-975.jpg",
    "rating": 5.0,
    "experience": "10 سنوات خبرة",
    "description":
        "خبير في أمراض القلب والقسطرة العلاجية، حاصل على الزمالة الأمريكية لأمراض القلب",
    "appointments": [
      {'time': '09:00 ص', 'date': 'الإثنين 15 يونيو', 'available': true},
      {'time': '11:30 ص', 'date': 'الإثنين 15 يونيو', 'available': false},
      {'time': '02:00 م', 'date': 'الإثنين 15 يونيو', 'available': true},
    ],
  },
  {
    "id": "2",
    "name": "د. هاجر",
    "specialty": "أخصائي أسنان",
    "image":
        "https://img.freepik.com/free-photo/portrait-smiling-young-woman-doctor-healthcare-medical-worker-pointing-fingers-left-showing-clini_1258-88108.jpg", // صورة لامرأة (دكتورة أسنان)
    "rating": 4.0,
    "experience": "3 سنوات خبرة",
    "description": "متخصصة في تجميل الأسنان وزراعة الأسنان الحديثة",
    "appointments": [
      {'time': '10:00 ص', 'date': 'الثلاثاء 16 يونيو', 'available': true},
      {'time': '12:30 م', 'date': 'الثلاثاء 16 يونيو', 'available': true},
      {'time': '04:00 م', 'date': 'الثلاثاء 16 يونيو', 'available': false},
    ],
  },
  {
    "id": "3",
    "name": "د. يوسف",
    "specialty": "أخصائي جراحة عامة",
    "image":
        "https://img.freepik.com/free-photo/doctor-with-his-arms-crossed-white-background_1368-5790.jpg", // صورة لشخص (دكتور جراحة)
    "rating": 4.5,
    "experience": "4 سنة خبرة",
    "description": "متخصص في الجراحة العامة والعلاج بالمنظار",
    "appointments": [
      {'time': '09:30 ص', 'date': 'الأربعاء 17 يونيو', 'available': true},
      {'time': '02:30 م', 'date': 'الأربعاء 17 يونيو', 'available': true},
      {'time': '05:00 م', 'date': 'الأربعاء 17 يونيو', 'available': false},
    ],
  },
  {
    "id": "4",
    "name": "د. مريم",
    "specialty": "أخصائية نساء وتوليد",
    "image":
        "https://i.pinimg.com/474x/20/f0/3d/20f03d2dc59c8f04ddcb6d6b602a0ebb.jpg", // صورة لامرأة (دكتورة نساء وتوليد)
    "rating": 4.8,
    "experience": "5 سنوات خبرة",
    "description": "أخصائية نساء وتوليد، تقدم خدمات متكاملة للأم والطفل",
    "appointments": [
      {'time': '09:00 ص', 'date': 'الخميس 18 يونيو', 'available': true},
      {'time': '01:00 م', 'date': 'الخميس 18 يونيو', 'available': true},
      {'time': '04:30 م', 'date': 'الخميس 18 يونيو', 'available': false},
    ],
  },
  {
    "id": "5",
    "name": "د. علي",
    "specialty": "أخصائي جلدية",
    "image":
        "https://img.freepik.com/free-photo/doctor-with-his-arms-crossed-white-background_1368-5790.jpg", // صورة لشخص (دكتور جلدية)
    "rating": 4.5,
    "experience": "4 سنة خبرة",
    "description": "متخصص في الجراحة العامة والعلاج بالمنظار",
    "appointments": [
      {'time': '09:30 ص', 'date': 'الأربعاء 17 يونيو', 'available': false},
      {'time': '02:30 م', 'date': 'الأربعاء 17 يونيو', 'available': false},
      {'time': '05:00 م', 'date': 'الأربعاء 17 يونيو', 'available': false},
    ],
  },
];

class Patient {
  final String? id;
  final String? name;
  final int? age;
  final String? phone;
  final String? email;
  final String? address;
  final String? image;
  final List<String>? chronicDiseases;
  final List<String>? allergies;
  final List<String>? currentMedications;
  final List<String>? surgicalHistory;

  Patient({
    this.id,
    this.name,
    this.age,
    this.phone,
    this.email,
    this.address,
    this.image,
    this.chronicDiseases,
    this.allergies,
    this.currentMedications,
    this.surgicalHistory,
  });
}

final List<Patient> patients = [
  Patient(
    id: '1',
    name: 'أحمد محمد',
    age: 45,
    phone: '01234567890',
    email: 'ahmed@example.com',
    address: '123 شارع الرئيسي، القاهرة',
    image: 'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg',
    chronicDiseases: ['ضغط دم مرتفع', 'سكري'],
    allergies: ['حساسية من البنسلين'],
    currentMedications: ['أسبرين 100 مجم', 'ميتفورمين 500 مجم'],
    surgicalHistory: ['عملية قلب مفتوح - 2018'],
  ),
  Patient(
    id: '01090438632',
    name: 'يوسف شعبان',
    age: 22,
    phone: '01090438632',
    email: 'yousef@example.com',
    address: '456 شارع النصر، الجيزة',
    image: 'https://b.top4top.io/p_3401vpliv1.jpg',
    chronicDiseases: ['ربو'],
    allergies: ['حساسية من الغبار'],
    currentMedications: ['فنتولين'],
    surgicalHistory: ['عملية زائدة دودية - 2015'],
  ),
  Patient(
    id: '3',
    name: 'خالد أحمد',
    age: 50,
    phone: '01098765432',
    email: 'khaled@example.com',
    address: '789 شارع السلام، الإسكندرية',
    image: 'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg',
    chronicDiseases: ['ضغط دم مرتفع'],
    allergies: ['حساسية من الأسماك'],
    currentMedications: ['أملوديبين 5 مجم'],
    surgicalHistory: ['عملية كسر في الساق - 2019'],
  ),
];

enum AppointmentStatus {
  scheduled,
  completed,
  cancelled,
}

class Appointment {
  final String id;
  final String patientId;
  final String patientName;
  final DateTime date;
  final String time;
  final AppointmentStatus status;
  final String? doctorId;
  final String? type; // 'كشف جديد', 'متابعة', 'تحليل', 'إلخ'
  final String? notes;

  const Appointment({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.date,
    required this.time,
    required this.status,
    this.doctorId,
    this.type,
    this.notes,
  });
}

// Available time slots for appointments
final List<String> availableTimes = [
  '09:00 ص',
  '09:30 ص',
  '10:00 ص',
  '10:30 ص',
  '11:00 ص',
  '11:30 ص',
  '12:00 م',
  '12:30 م',
  '01:00 م',
  '01:30 م',
  '02:00 م',
  '02:30 م',
  '03:00 م',
  '03:30 م',
  '04:00 م',
  '04:30 م',
];

// Sample appointments
final List<Appointment> appointments = [
  Appointment(
    id: '1',
    patientId: '1',
    patientName: 'John Doe',
    date: DateTime(2024, 3, 20),
    time: '10:00 ص',
    status: AppointmentStatus.scheduled,
    doctorId: '1',
    type: 'كشف جديد',
    notes: 'متابعة حالة القلب',
  ),
  Appointment(
    id: '2',
    patientId: '01090438632',
    patientName: 'Jane Doe',
    date: DateTime(2024, 3, 20),
    time: '11:30 ص',
    status: AppointmentStatus.scheduled,
    doctorId: '1',
    type: 'متابعة',
    notes: 'متابعة التحاليل',
  ),
  Appointment(
    id: '3',
    patientId: '3',
    patientName: 'Bob Smith',
    date: DateTime(2024, 3, 20),
    time: '01:00 م',
    status: AppointmentStatus.scheduled,
    doctorId: '1',
    type: 'كشف جديد',
  ),
];

class Prescription {
  final String? id;
  final String? patientId;
  final String? doctorId;
  final DateTime? date;
  final String? visitType;
  final String? symptoms;
  final List<String>? requiredTests;
  final List<Medication>? medications;
  final String? notes;

  Prescription({
    this.id,
    this.patientId,
    this.doctorId,
    this.date,
    this.visitType,
    this.symptoms,
    this.requiredTests,
    this.medications,
    this.notes,
  });
}

class Medication {
  final String? name;
  final String? dosage;
  final String? duration;

  Medication({this.name, this.dosage, this.duration});
}

final List<Prescription> prescriptions = [
  Prescription(
    id: '1',
    patientId: '01090438632',
    doctorId: '1',
    date: DateTime(2024, 3, 15),
    visitType: 'كشف قلب',
    symptoms: 'ألم في الصدر وضيق في التنفس',
    requiredTests: ['تخطيط القلب', 'تحليل دم شامل', 'قياس ضغط الدم'],
    medications: [
      Medication(
        name: 'أسبرين',
        dosage: '100 مجم',
        duration: 'مرة واحدة يومياً',
      ),
      Medication(
        name: 'ميتفورمين',
        dosage: '500 مجم',
        duration: 'مرتين يومياً',
      ),
    ],
    notes: 'تناول الدواء بعد الأكل مباشرة',
  ),
  Prescription(
    id: '2',
    patientId: '01090438632',
    doctorId: '1',
    date: DateTime(2024, 3, 10),
    visitType: 'كشف صدر',
    symptoms: 'سعال وارتفاع في درجة الحرارة',
    medications: [
      Medication(name: 'فنتولين', dosage: '2 بخة', duration: 'كل 4 ساعات'),
    ],
    notes: 'استخدام البخاخ عند الحاجة',
  ),
  Prescription(
    id: '3',
    patientId: '3',
    doctorId: '1',
    date: DateTime(2024, 3, 5),
    visitType: 'كشف علاجي',
    symptoms: 'ألم في الصدر وضيق في التنفس',
    requiredTests: ['تخطيط القلب', 'تحليل دم شامل', 'قياس ضغط الدم'],
    medications: [
      Medication(
        name: 'أسبرين',
        dosage: '100 مجم',
        duration: 'مرة واحدة يومياً',
      ),
    ],
    notes: 'تناول الدواء بعد الأكل مباشرة',
  ),
];
final profile = {
  'id': '1',
  'name': SharedHelper.get(SharedKeys.name) ?? "youssef",
  'specialization':
      SharedHelper.get(SharedKeys.role) == "admin" ? "معمل" : "طبيب عام",
  'gender': SharedHelper.get(SharedKeys.gender) ?? "male",
  "image": SharedHelper.get(SharedKeys.image) ??
      "https://b.top4top.io/p_3401vpliv1.jpg",
  'age': '22 سنة',
  'birthDate': SharedHelper.get(SharedKeys.dateOfBirth) ?? "",
  'phone': SharedHelper.get(SharedKeys.phone) ?? "No Phone",
  'email': SharedHelper.get(SharedKeys.email) ?? "email@example.com",
  'bloodType': 'B+',
};
