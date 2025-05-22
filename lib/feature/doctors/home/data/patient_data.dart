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
