import 'package:healthy_sync/core/widgets/data.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Patient> patients;
  final List<Patient> filteredPatients;

  HomeLoaded({
    required this.patients,
    List<Patient>? filteredPatients,
  }) : filteredPatients = filteredPatients ?? patients;
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
