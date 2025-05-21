class DoctorVisit {
  final String id;
  final String doctorName;
  final String specialization;
  final String imageUrl;
  final double rating;
  final int experienceYears;
  final String phoneNumber;
  final String date;
  final String time;
  final String status;
  final String diagnosis;
  final String symptoms;
  final String treatment;
  final String medications;
  final List<String> recommendations;
  final String followUpDate;

  DoctorVisit({
    required this.id,
    required this.doctorName,
    required this.specialization,
    required this.imageUrl,
    required this.rating,
    required this.experienceYears,
    required this.phoneNumber,
    required this.date,
    required this.time,
    required this.status,
    required this.diagnosis,
    required this.symptoms,
    required this.treatment,
    required this.medications,
    required this.recommendations,
    required this.followUpDate,
  });

  factory DoctorVisit.fromJson(Map<String, dynamic> json) {
    return DoctorVisit(
      id: json['id'] as String,
      doctorName: json['doctorName'] as String,
      specialization: json['specialization'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      experienceYears: json['experienceYears'] as int,
      phoneNumber: json['phoneNumber'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      status: json['status'] as String,
      diagnosis: json['diagnosis'] as String,
      symptoms: json['symptoms'] as String,
      treatment: json['treatment'] as String,
      medications: json['medications'] as String,
      recommendations: List<String>.from(json['recommendations'] as List),
      followUpDate: json['followUpDate'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorName': doctorName,
      'specialization': specialization,
      'imageUrl': imageUrl,
      'rating': rating,
      'experienceYears': experienceYears,
      'phoneNumber': phoneNumber,
      'date': date,
      'time': time,
      'status': status,
      'diagnosis': diagnosis,
      'symptoms': symptoms,
      'treatment': treatment,
      'medications': medications,
      'recommendations': recommendations,
      'followUpDate': followUpDate,
    };
  }

  static DoctorVisit lastVisit = DoctorVisit(
    id: "1",
    doctorName: "د. أحمد محمد",
    specialization: "طب عام",
    imageUrl: "https://example.com/doctor.jpg",
    rating: 4.5,
    experienceYears: 10,
    phoneNumber: "0123456789",
    date: "15 مارس 2024",
    time: "10:00 صباحاً",
    status: "مستقر",
    diagnosis: "ارتفاع في ضغط الدم",
    symptoms: "الصداع، الإرهاق، الإرتفاع في ضغط الدم",
    treatment: "العلاج الطبيعي، التغذية الصحية، التمارين الرياضية",
    medications: "الأدوية المناسبة للضغط العالي",
    recommendations: [
      "التغذية الصحية",
      "التمارين الرياضية",
      "التغذية الصحية",
      "التمارين الرياضية",
    ],
    followUpDate: "15 مارس 2024",
  );
}
