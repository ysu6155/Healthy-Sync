class MedicalTestsData {
  // بيانات التحاليل الطبية
  static final List<Map<String, dynamic>> labTests = [
    {
      'name': 'تحليل دم شامل',
      'date': '2025-03-15',
      'type': 'تحليل دم',
      'status': 'مكتمل',
      'description': 'تحليل دم شامل للكشف عن الأمراض',
      'doctor': 'د. أحمد محمد',
      'notes': 'جميع النتائج ضمن المعدل الطبيعي',
      'imageUrl':
          'https://i.pinimg.com/736x/90/d1/6d/90d16dfbfaedcc307a59d9c1cb5aed61.jpg',
      'results': [
        {
          'name': 'الهيموجلوبين',
          'value': '14.5 g/dL',
          'normalRange': '13.5 - 17.5 g/dL',
          'status': 'طبيعي',
        },
        {
          'name': 'عدد كرات الدم البيضاء',
          'value': '11.2 x10^9/L',
          'normalRange': '4.5 - 11.0 x10^9/L',
          'status': 'مرتفع',
        },
        {
          'name': 'الصفائح الدموية',
          'value': '250 x10^9/L',
          'normalRange': '150 - 450 x10^9/L',
          'status': 'طبيعي',
        },
      ],
    },
    {
      'name': 'تحليل بول',
      'date': '2025-05-10',
      'type': 'تحليل بول',
      'status': 'مكتمل',
      'description': 'تحليل بول روتيني',
      'doctor': 'د. محمد علي',
      'imageUrl':
          'https://i.pinimg.com/736x/90/d1/6d/90d16dfbfaedcc307a59d9c1cb5aed61.jpg',
      'notes': 'لا توجد نتائج غير طبيعية',
      'results': [
        {
          'name': 'البروتين',
          'value': 'سلبي',
          'normalRange': 'سلبي',
          'status': 'طبيعي',
        },
        {
          'name': 'السكر',
          'value': 'سلبي',
          'normalRange': 'سلبي',
          'status': 'طبيعي',
        },
      ],
    },
    {
      'name': 'تحليل براز',
      'date': '2024-03-05',
      'type': 'تحليل براز',
      'status': 'في انتظار النتائج',
      'imageUrl':
          'https://i.pinimg.com/736x/90/d1/6d/90d16dfbfaedcc307a59d9c1cb5aed61.jpg',
      'description': 'تحليل براز للكشف عن الطفيليات',
      'doctor': 'د. سارة أحمد',
      'notes': 'قيد المراجعة',
    },
  ];

  // بيانات الأشعة
  static final List<Map<String, dynamic>> xrayTests = [
    {
      'name': 'أشعة سينية على الصدر',
      'date': '2024-03-18',
      'type': 'أشعة سينية',
      'status': 'مكتمل',
      'description': 'أشعة سينية على الصدر للكشف عن أمراض الرئة',
      'doctor': 'د. خالد محمود',
      'notes': 'لا توجد نتائج غير طبيعية',
      'imageUrl':
          'https://i.pinimg.com/736x/90/d1/6d/90d16dfbfaedcc307a59d9c1cb5aed61.jpg',
    },
    {
      'name': 'رنين مغناطيسي على المخ',
      'date': '2024-03-12',
      'type': 'رنين مغناطيسي',
      'status': 'مكتمل',
      'description': 'رنين مغناطيسي على المخ للكشف عن أي أورام',
      'doctor': 'د. محمد علي',
      'notes': 'النتائج طبيعية، لا توجد أورام',
      'imageUrl': '',
    },
    {
      'name': 'أشعة مقطعية على البطن',
      'date': '2024-03-08',
      'type': 'أشعة مقطعية',
      'status': 'في انتظار النتائج',
      'description':
          'أشعة مقطعية على البطن للكشف عن أي مشاكل في الأعضاء الداخلية',
      'doctor': 'د. سارة أحمد',
      'notes': 'قيد المراجعة',
      'imageUrl': '',
    },
  ];

  // الحصول على آخر التحاليل والأشعة
  static List<Map<String, dynamic>> getRecentTests() {
    final allTests = [...labTests, ...xrayTests];
    allTests.sort((a, b) =>
        DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));
    return allTests.take(5).toList();
  }

  // الحصول على آخر التحاليل فقط
  static List<Map<String, dynamic>> getRecentLabTests() {
    final sortedTests = List<Map<String, dynamic>>.from(labTests);
    sortedTests.sort((a, b) =>
        DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));
    return sortedTests.take(3).toList();
  }

  // الحصول على آخر الأشعة فقط
  static List<Map<String, dynamic>> getRecentXrayTests() {
    final sortedTests = List<Map<String, dynamic>>.from(xrayTests);
    sortedTests.sort((a, b) =>
        DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));
    return sortedTests.take(3).toList();
  }
}
