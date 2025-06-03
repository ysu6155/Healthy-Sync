import 'package:equatable/equatable.dart';
import 'package:healthy_sync/core/widgets/data.dart';

abstract class AppointmentsState extends Equatable {
  const AppointmentsState();

  @override
  List<Object?> get props => [];
}

class AppointmentsInitial extends AppointmentsState {}

class AppointmentsLoading extends AppointmentsState {}

class AppointmentsError extends AppointmentsState {
  final String message;

  const AppointmentsError(this.message);

  @override
  List<Object?> get props => [message];
}

class AppointmentsSuccess extends AppointmentsState {
  final List<Appointment> appointments;

  const AppointmentsSuccess(this.appointments);

  @override
  List<Object?> get props => [appointments];
}
