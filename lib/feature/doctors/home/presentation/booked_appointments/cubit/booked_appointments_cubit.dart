import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/core/widgets/data.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/booked_appointments/cubit/booked_appointments_state.dart';

class BookedAppointmentsCubit extends Cubit<BookedAppointmentsState> {
  BookedAppointmentsCubit() : super(BookedAppointmentsInitial());

  Future<void> getBookedAppointments() async {
    try {
      emit(BookedAppointmentsLoading());
      // TODO: Implement API call to get booked appointments
      await Future.delayed(const Duration(seconds: 1));

      // Using data from appointment_data.dart
      final bookedAppointments = appointments
          .where((appointment) =>
              appointment.status == AppointmentStatus.scheduled)
          .toList();

      emit(BookedAppointmentsSuccess(bookedAppointments));
    } catch (e) {
      emit(BookedAppointmentsError(e.toString()));
    }
  }

  Future<void> refreshBookedAppointments() async {
    await getBookedAppointments();
  }
}
