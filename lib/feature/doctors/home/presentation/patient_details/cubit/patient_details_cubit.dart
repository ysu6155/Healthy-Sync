import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/core/widgets/data.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/patient_details/cubit/patient_details_state.dart';

class PatientDetailsCubit extends Cubit<PatientDetailsState> {
  PatientDetailsCubit() : super(PatientDetailsInitial());

  Future<void> getPatientDetails() async {
    try {
      emit(PatientDetailsLoading());
      // TODO: Implement API call to get patient details
      // For now, using mock data
      await Future.delayed(const Duration(seconds: 1));

      emit(PatientDetailsSuccess(patients));
    } catch (e) {
      emit(PatientDetailsError(e.toString()));
    }
  }
}
