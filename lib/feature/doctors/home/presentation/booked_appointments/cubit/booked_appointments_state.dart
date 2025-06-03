import 'package:healthy_sync/core/widgets/data.dart';

abstract class BookedAppointmentsState {}

class BookedAppointmentsInitial extends BookedAppointmentsState {}

class BookedAppointmentsLoading extends BookedAppointmentsState {}

class BookedAppointmentsSuccess extends BookedAppointmentsState {
  final List<Appointment> appointments;

  BookedAppointmentsSuccess(this.appointments);
}

class BookedAppointmentsError extends BookedAppointmentsState {
  final String message;

  BookedAppointmentsError(this.message);
}
