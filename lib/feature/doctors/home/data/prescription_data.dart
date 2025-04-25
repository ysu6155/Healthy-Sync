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
    patientId: '2',
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
    patientId: '2',
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
    patientId: '2',
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
