import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/core/widgets/data.dart';
import 'package:healthy_sync/feature/doctors/home/presentation/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getPatients() async {
    try {
      emit(HomeLoading());
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      emit(HomeLoaded(patients: patients));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> refreshPatients() async {
    await getPatients();
  }

  void searchPatients(String query) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      if (query.isEmpty) {
        emit(HomeLoaded(patients: currentState.patients));
        return;
      }

      final filteredPatients = currentState.patients.where((patient) {
        final name = patient.name?.toLowerCase() ?? '';
        final phone = patient.phone?.toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();

        return name.contains(searchQuery) || phone.contains(searchQuery);
      }).toList();

      emit(HomeLoaded(
        patients: currentState.patients,
        filteredPatients: filteredPatients,
      ));
    }
  }
}
