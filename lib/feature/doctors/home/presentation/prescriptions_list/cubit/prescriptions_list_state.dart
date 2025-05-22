import 'package:healthy_sync/feature/doctors/home/data/prescription_data.dart';

abstract class PrescriptionsListState {}

class PrescriptionsListInitial extends PrescriptionsListState {}

class PrescriptionsListLoading extends PrescriptionsListState {}

class PrescriptionsListSuccess extends PrescriptionsListState {
  final List<Prescription> prescriptions;

  PrescriptionsListSuccess(this.prescriptions);
}

class PrescriptionsListError extends PrescriptionsListState {
  final String message;

  PrescriptionsListError(this.message);
}
