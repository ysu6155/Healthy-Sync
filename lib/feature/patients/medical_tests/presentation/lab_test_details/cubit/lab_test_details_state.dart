part of 'lab_test_details_cubit.dart';

abstract class LabTestDetailsState {}

class LabTestDetailsInitial extends LabTestDetailsState {}

class LabTestDetailsLoading extends LabTestDetailsState {}

class LabTestDetailsLoaded extends LabTestDetailsState {
  final Map<String, dynamic> testData;

  LabTestDetailsLoaded({required this.testData});
}

class LabTestDetailsError extends LabTestDetailsState {
  final String message;

  LabTestDetailsError(this.message);
}
