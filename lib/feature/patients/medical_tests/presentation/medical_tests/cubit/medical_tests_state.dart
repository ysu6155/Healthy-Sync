part of 'medical_tests_cubit.dart';

abstract class MedicalTestsState {}

class MedicalTestsInitial extends MedicalTestsState {}

class MedicalTestsLoading extends MedicalTestsState {}

class MedicalTestsLoaded extends MedicalTestsState {
  final List<Map<String, dynamic>> recentTests;

  MedicalTestsLoaded({required this.recentTests});
}

class MedicalTestsError extends MedicalTestsState {
  final String message;

  MedicalTestsError(this.message);
}
