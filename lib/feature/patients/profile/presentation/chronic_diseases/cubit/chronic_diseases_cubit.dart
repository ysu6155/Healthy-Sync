import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/chronic_diseases/cubit/chronic_diseases_state.dart';

class ChronicDiseasesCubit extends Cubit<ChronicDiseasesState> {
  final formKey = GlobalKey<FormState>();
  final diseaseNameController = TextEditingController();
  final diagnosisDateController = TextEditingController();
  final treatmentController = TextEditingController();
  final notesController = TextEditingController();

  ChronicDiseasesCubit() : super(ChronicDiseasesInitial());

  Future<void> addChronicDisease() async {
    try {
      emit(ChronicDiseasesLoading());

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      emit(ChronicDiseasesSuccess('تم إضافة المرض المزمن بنجاح'));
    } catch (e) {
      emit(ChronicDiseasesError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    diseaseNameController.dispose();
    diagnosisDateController.dispose();
    treatmentController.dispose();
    notesController.dispose();
    return super.close();
  }
}
