import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/feature/patients/medical_tests/data/dummy_data.dart';

part 'medical_tests_state.dart';

class MedicalTestsCubit extends Cubit<MedicalTestsState> {
  MedicalTestsCubit() : super(MedicalTestsInitial());

  Future<void> loadData() async {
    emit(MedicalTestsLoading());
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      final recentTests = MedicalTestsData.getRecentTests();
      emit(MedicalTestsLoaded(recentTests: recentTests));
    } catch (e) {
      emit(MedicalTestsError('Failed to load medical tests'));
    }
  }

  Future<void> refresh() async {
    await loadData();
  }
}
