import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';

abstract class PrescriptionState {}

class PrescriptionInitial extends PrescriptionState {}

class PrescriptionLoading extends PrescriptionState {}

class PrescriptionSuccess extends PrescriptionState {
  final String message;

  PrescriptionSuccess(this.message);
}

class PrescriptionError extends PrescriptionState {
  final String message;

  PrescriptionError(this.message);
}
