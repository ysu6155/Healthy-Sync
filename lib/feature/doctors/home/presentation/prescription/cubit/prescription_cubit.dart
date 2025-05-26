import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';
import 'package:healthy_sync/feature/doctors/home/data/prescription_data.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/prescription/cubit/prescription_state.dart';

class PrescriptionCubit extends Cubit<PrescriptionState> {
  PrescriptionCubit() : super(PrescriptionInitial());

  Future<void> createPrescription({
    required Patient patient,
    String? symptoms,
    List<String>? requiredTests,
    List<Medication>? medications,
    String? notes,
  }) async {
    try {
      emit(PrescriptionLoading());

      final prescription = Prescription(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        patientId: patient.id ?? '',
        doctorId: '1',
        date: DateTime.now(),
        symptoms: symptoms ?? '',
        requiredTests: requiredTests ?? [],
        medications: medications ?? [],
        notes: notes ?? '',
      );

      // TODO: Implement API call to create prescription
      await Future.delayed(const Duration(seconds: 1));

      // Add the prescription to the list
      prescriptions.add(prescription);

      emit(PrescriptionSuccess('تم إنشاء الوصفة الطبية بنجاح'));
    } catch (e) {
      emit(PrescriptionError(e.toString()));
    }
  }
}
