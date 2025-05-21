import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/feature/doctors/home/data/data.dart';
import 'package:healthy_sync/feature/patients/home/presentation/doctor_details/cubit/doctor_details_state.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  DoctorDetailsCubit() : super(DoctorDetailsInitial());

  Future<void> refresh(String doctorId) async {
    loadDoctorDetails(doctorId);
  }

  Future<void> loadDoctorDetails(String doctorId) async {
    try {
      emit(DoctorDetailsLoading());
      // TODO: Implement API call to get doctor details
      // For now, we'll simulate a delay
      await Future.delayed(const Duration(seconds: 1));

      // Simulated doctor data

      emit(DoctorDetailsLoaded(doctor: doctors));
    } catch (e) {
      emit(DoctorDetailsError(message: 'حدث خطأ أثناء تحميل بيانات الطبيب'));
    }
  }

  Future<void> bookAppointment(
      String doctorId, String date, String time) async {
    try {
      // TODO: Implement API call to book appointment
      await Future.delayed(const Duration(seconds: 1));

      // Simulate successful booking
      if (state is DoctorDetailsLoaded) {
        final currentState = state as DoctorDetailsLoaded;
        final updatedDoctor =
            Map<String, dynamic>.from(currentState.doctor.first);
        final appointments =
            List<Map<String, dynamic>>.from(updatedDoctor['appointments']);

        // Update appointment availability
        for (var appointment in appointments) {
          if (appointment['date'] == date && appointment['time'] == time) {
            appointment['available'] = false;
            break;
          }
        }

        updatedDoctor['appointments'] = appointments;
        emit(DoctorDetailsLoaded(doctor: [updatedDoctor]));
      }
    } catch (e) {
      emit(DoctorDetailsError(message: 'حدث خطأ أثناء حجز الموعد'));
    }
  }
}
