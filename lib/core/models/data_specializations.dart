import 'package:flutter/material.dart';

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
];

final List<Map<String, dynamic>> doctors = [
  {
    "name": "د. أحمد",
    "specialty": "أخصائي قلب",
    "image": "https://j.top4top.io/p_3385km94e1.png",
    "rating": 3.0,
    "experience": "10 سنوات خبرة",
    "description":
        "خبير في أمراض القلب والقسطرة العلاجية، حاصل على الزمالة الأمريكية لأمراض القلب",
  },
  {
    "name": "د. سارة",
    "specialty": "أخصائي أسنان",
    "image":
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "rating": 4.0,
    "experience": "7 سنوات خبرة",
    "description": "متخصصة في تجميل الأسنان وزراعة الأسنان الحديثة",
  },
  {
    "name": "د. إميليا",
    "specialty": "أخصائي أعصاب",
    "image":
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "rating": 1.1,
    "experience": "3 سنوات خبرة",
    "description": "تشخيص وعلاج أمراض الجهاز العصبي والصداع المزمن",
  },
  {
    "name": "د. مايكل",
    "specialty": "أخصائي أطفال",
    "image":
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "rating": 0.5,
    "experience": "5 سنوات خبرة",
    "description": "رعاية حديثي الولادة والتحصينات والتغذية السليمة للأطفال",
  },
  {
    "name": "د. جون",
    "specialty": "أخصائي عظام",
    "image":
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "rating": 2.5,
    "experience": "8 سنوات خبرة",
    "description": "جراحات العظام والكسور ومناظير المفاصل",
  },
  {
    "name": "د. منى",
    "specialty": "أخصائي عيون",
    "image":
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "rating": 4.5,
    "experience": "12 سنة خبرة",
    "description": "تصحيح النظر بالليزر وعلاج أمراض الشبكية",
  },
  {
    "name": "د. ياما",
    "specialty": "أخصائي نساء وولادة",
    "image":
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "rating": 3.5,
    "experience": "9 سنوات خبرة",
    "description": "متابعة الحمل والولادة الطبيعية والقيصرية",
  },
  {
    "name": "د. يوسف",
    "specialty": "أخصائي قلب",
    "image":
        "https://images.pexels.com/photos/220454/pexels-photo-220454.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "rating": 5.0,
    "experience": "15 سنة خبرة",
    "description": "أستاذ أمراض القلب بكلية الطب وجراحات القلب المفتوح",
  },
];
