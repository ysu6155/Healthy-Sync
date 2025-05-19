part of 'treatment_schedule_cubit.dart';

abstract class TreatmentScheduleState {}

class TreatmentScheduleInitial extends TreatmentScheduleState {}

class TreatmentScheduleLoading extends TreatmentScheduleState {}

class TreatmentScheduleLoaded extends TreatmentScheduleState {
  final List<Map<String, dynamic>> schedules;

  TreatmentScheduleLoaded({required this.schedules});
}

class TreatmentScheduleError extends TreatmentScheduleState {
  final String message;

  TreatmentScheduleError(this.message);
}
