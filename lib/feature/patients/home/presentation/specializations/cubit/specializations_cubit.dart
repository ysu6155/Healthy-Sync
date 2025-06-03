import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/core/widgets/data.dart';
import 'package:healthy_sync/feature/patients/home/presentation/specializations/cubit/specializations_state.dart';

class SpecializationsCubit extends Cubit<SpecializationsState> {
  SpecializationsCubit() : super(SpecializationsInitial());

  Future<void> loadSpecializations() async {
    try {
      emit(SpecializationsLoading());

      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      emit(SpecializationsLoaded(
        specializations: specializations,
      ));
    } catch (e) {
      emit(SpecializationsError(
        message: 'حدث خطأ أثناء تحميل التخصصات',
      ));
    }
  }

  void searchSpecializations(String query) {
    if (state is SpecializationsLoaded) {
      if (query.isEmpty) {
        emit(SpecializationsLoaded(
          specializations: specializations,
        ));
        return;
      }

      final filteredSpecializations = specializations
          .where((specialty) => specialty['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();

      emit(SpecializationsLoaded(
        specializations: filteredSpecializations,
        searchQuery: query,
      ));
    }
  }
}
