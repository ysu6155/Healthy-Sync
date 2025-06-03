import 'package:healthy_sync/core/widgets/data.dart';

abstract class PatientDetailsState {}

class PatientDetailsInitial extends PatientDetailsState {}

class PatientDetailsLoading extends PatientDetailsState {}

class PatientDetailsSuccess extends PatientDetailsState {
  final List<Patient> patient;

  PatientDetailsSuccess(this.patient);
}

class PatientDetailsError extends PatientDetailsState {
  final String message;

  PatientDetailsError(this.message);
}
