import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/feature/patients/home/data/repositories/doctor_visit_repository.dart';
import 'package:healthy_sync/feature/patients/home/presentation/doctor_visit/cubit/doctor_visit_state.dart';

class DoctorVisitCubit extends Cubit<DoctorVisitState> {
  final DoctorVisitRepository _repository;

  DoctorVisitCubit({required DoctorVisitRepository repository})
      : _repository = repository,
        super(DoctorVisitInitial());

  Future<void> getVisitDetails(String visitId) async {
    try {
      emit(DoctorVisitLoading());
      final visit = await _repository.getVisitDetails(visitId);
      emit(DoctorVisitLoaded(visit: visit));
    } catch (e) {
      emit(DoctorVisitError(message: e.toString()));
    }
  }
}
