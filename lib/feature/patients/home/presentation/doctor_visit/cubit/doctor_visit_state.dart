import 'package:equatable/equatable.dart';
import 'package:healthy_sync/feature/patients/home/data/models/doctor_visit.dart';

abstract class DoctorVisitState extends Equatable {
  const DoctorVisitState();

  @override
  List<Object?> get props => [];
}

class DoctorVisitInitial extends DoctorVisitState {}

class DoctorVisitLoading extends DoctorVisitState {}

class DoctorVisitLoaded extends DoctorVisitState {
  final DoctorVisit visit;

  const DoctorVisitLoaded({required this.visit});

  @override
  List<Object?> get props => [visit];
}

class DoctorVisitError extends DoctorVisitState {
  final String message;

  const DoctorVisitError({required this.message});

  @override
  List<Object?> get props => [message];
}
