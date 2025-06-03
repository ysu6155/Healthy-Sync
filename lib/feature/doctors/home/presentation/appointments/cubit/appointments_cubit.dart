import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/core/widgets/data.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/appointments/cubit/appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  AppointmentsCubit() : super(AppointmentsInitial());

  List<Appointment> _appointments = [];

  Future<void> getAppointments() async {
    try {
      emit(AppointmentsLoading());
      // TODO: Implement API call to get appointments
      await Future.delayed(const Duration(seconds: 1));

      // For now, using dummy data

      emit(AppointmentsSuccess(_appointments));
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }

  Future<void> refreshAppointments() async {
    await getAppointments();
  }

  void saveAppointments(DateTime selectedDate, List<String> selectedTimes) {
    try {
      // Remove all existing available appointments for the selected date
      _appointments.removeWhere(
        (appointment) =>
            appointment.status == AppointmentStatus.scheduled &&
            appointment.date.year == selectedDate.year &&
            appointment.date.month == selectedDate.month &&
            appointment.date.day == selectedDate.day,
      );

      // Add new available appointments
      for (String time in selectedTimes) {
        _appointments.add(
          Appointment(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            patientId: '01090438638', // Placeholder for available slot
            patientName: 'موعد متاح',
            date: selectedDate,
            time: time,
            status: AppointmentStatus.scheduled,
            doctorId: '1', // TODO: Get from auth
            type: 'كشف جديد',
          ),
        );
      }

      emit(AppointmentsSuccess(_appointments));
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }
}
