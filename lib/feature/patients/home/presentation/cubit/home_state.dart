import 'package:equatable/equatable.dart';
import 'package:healthy_sync/feature/patients/home/data/models/doctor_visit.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final bool isRefreshing;
  final bool isSpecializationsLoading;
  final bool isDoctorsLoading;
  final bool isVisitLoading;
  final String? error;
  final List<Map<String, dynamic>> specializations;
  final List<Map<String, dynamic>> doctors;
  final DoctorVisit? visitData;

  const HomeState({
    this.isLoading = true,
    this.isRefreshing = false,
    this.isSpecializationsLoading = true,
    this.isDoctorsLoading = true,
    this.isVisitLoading = true,
    this.error,
    this.specializations = const [],
    this.doctors = const [],
    this.visitData,
  });

  HomeState copyWith({
    bool? isLoading,
    bool? isRefreshing,
    bool? isSpecializationsLoading,
    bool? isDoctorsLoading,
    bool? isVisitLoading,
    String? error,
    List<Map<String, dynamic>>? specializations,
    List<Map<String, dynamic>>? doctors,
    DoctorVisit? visitData,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isSpecializationsLoading:
          isSpecializationsLoading ?? this.isSpecializationsLoading,
      isDoctorsLoading: isDoctorsLoading ?? this.isDoctorsLoading,
      isVisitLoading: isVisitLoading ?? this.isVisitLoading,
      error: error,
      specializations: specializations ?? this.specializations,
      doctors: doctors ?? this.doctors,
      visitData: visitData ?? this.visitData,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isRefreshing,
        isSpecializationsLoading,
        isDoctorsLoading,
        isVisitLoading,
        error,
        specializations,
        doctors,
        visitData,
      ];
}
