import 'package:healthy_sync/feature/patients/home/data/models/doctor_visit.dart';

abstract class DoctorVisitRepository {
  Future<DoctorVisit> getVisitDetails(String visitId);
}

class DoctorVisitRepositoryImpl implements DoctorVisitRepository {
  @override
  Future<DoctorVisit> getVisitDetails(String visitId) async {
    // TODO: Implement API call to get visit details
    // For now, return mock data
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    return DoctorVisit(
      id: visitId,
      doctorName: "د. أحمد محمد",
      specialization: "طب عام",
      imageUrl: "",
      rating: 4.9,
      experienceYears: 10,
      phoneNumber: "01234567890",
      date: "2024-03-20",
      time: "10:00 صباحاً",
      status: "مكتملة",
      diagnosis: "نزلة برد خفيفة",
      symptoms: "سعال، ارتفاع في درجة الحرارة، صداع",
      treatment: "راحة تامة، شرب سوائل دافئة",
      medications: "باراسيتامول, فيتامين سي",
      recommendations: [
        "الراحة التامة لمدة يومين",
        "شرب السوائل الدافئة بكثرة",
        "تجنب التعرض للبرد",
        "تناول الطعام الصحي",
      ],
      followUpDate: "2024-03-27",
    );
  }
}
