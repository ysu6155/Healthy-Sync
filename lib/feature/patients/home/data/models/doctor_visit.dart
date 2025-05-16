class DoctorVisit {
  final String doctorName;
  final String specialization;
  final String date;
  final String time;
  final String diagnosis;
  final String symptoms;
  final String treatment;
  final String notes;
  final String status;
  final List<String> medications;
  final List<String> recommendations;

  const DoctorVisit({
    required this.doctorName,
    required this.specialization,
    required this.date,
    required this.time,
    required this.diagnosis,
    required this.symptoms,
    required this.treatment,
    required this.notes,
    required this.status,
    required this.medications,
    required this.recommendations,
  });

  static const lastVisit = DoctorVisit(
    doctorName: "د. أحمد محمد",
    specialization: "طب عام",
    date: "15 مارس 2024",
    time: "10:00 صباحاً",
    diagnosis: "ارتفاع في ضغط الدم",
    symptoms: "صداع مستمر، دوخة، تعب عام",
    treatment: "وصف الطبيب العلاج المناسب مع ضرورة المتابعة الدورية",
    notes: "يجب مراعاة النظام الغذائي وتجنب الأملاح والكافيين",
    status: "مستقر",
    medications: [
      "أملوديبين 5 مجم - قرص يومياً",
      "لوسارتان 50 مجم - قرص يومياً",
    ],
    recommendations: [
      "قياس الضغط يومياً",
      "تجنب الأطعمة المالحة",
      "ممارسة الرياضة بشكل منتظم",
      "الالتزام بمواعيد الدواء",
    ],
  );
}
