import 'package:healthy_sync/core/widgets/data.dart';
import 'package:healthy_sync/feature/patients/home/data/models/doctor_visit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Patient>? patients;
  final List<Patient>? filteredPatients;
  final Map<String, dynamic>? profile;
  final bool isLoading;
  final bool isRefreshing;
  final bool isSpecializationsLoading;
  final bool isDoctorsLoading;
  final bool isVisitLoading;
  final String? error;
  final List<Map<String, dynamic>> specializations;
  final List<Map<String, dynamic>> doctors;
  final DoctorVisit? visitData;

  HomeLoaded({
    this.patients,
    List<Patient>? filteredPatients,
    this.profile,
    this.isLoading = false,
    this.isRefreshing = false,
    this.isSpecializationsLoading = false,
    this.isDoctorsLoading = false,
    this.isVisitLoading = false,
    this.error,
    this.specializations = const [],
    this.doctors = const [],
    this.visitData,
  }) : filteredPatients = filteredPatients ?? patients;

}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
