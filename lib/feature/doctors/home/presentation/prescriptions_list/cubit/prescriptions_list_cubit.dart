import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/core/widgets/data.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/prescriptions_list/cubit/prescriptions_list_state.dart';

class PrescriptionsListCubit extends Cubit<PrescriptionsListState> {
  PrescriptionsListCubit() : super(PrescriptionsListInitial());

  Future<void> getPrescriptions({required Patient patient}) async {
    try {
      emit(PrescriptionsListLoading());
      // TODO: Implement API call to get prescriptions
      await Future.delayed(const Duration(seconds: 1));

      // Filter prescriptions for the specific patient
      final patientPrescriptions = prescriptions
          .where((prescription) => prescription.patientId == patient.id)
          .toList();

      emit(PrescriptionsListSuccess(patientPrescriptions));
    } catch (e) {
      emit(PrescriptionsListError(e.toString()));
    }
  }
}
