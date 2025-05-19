part of 'lab_tests_cubit.dart';

abstract class LabTestsState {}

class LabTestsInitial extends LabTestsState {}

class LabTestsLoading extends LabTestsState {}

class LabTestsLoaded extends LabTestsState {
  final List<Map<String, dynamic>> labTests;
  final String? filterPeriod;

  LabTestsLoaded({required this.labTests, this.filterPeriod});
}

class LabTestsError extends LabTestsState {
  final String message;

  LabTestsError(this.message);
}
