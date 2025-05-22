import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/feature/doctors/home/data/data.dart';
import 'package:healthy_sync/feature/patients/home/presentation/doctors_by_specialty/cubit/doctors_by_specialty_state.dart';

class DoctorsBySpecialtyCubit extends Cubit<DoctorsBySpecialtyState> {
  DoctorsBySpecialtyCubit() : super(DoctorsBySpecialtyInitial());

  Future<void> loadDoctorsBySpecialty(String specialty) async {
    try {
      emit(DoctorsBySpecialtyLoading());

      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      // Filter doctors by specialty
      final filteredDoctors =
          doctors.where((doctor) => doctor['specialty'] == specialty).toList();

      emit(DoctorsBySpecialtyLoaded(
        doctors: filteredDoctors,
        specialty: specialty,
      ));
    } catch (e) {
      emit(DoctorsBySpecialtyError(
        message: 'حدث خطأ أثناء تحميل بيانات الأطباء',
      ));
    }
  }
}
