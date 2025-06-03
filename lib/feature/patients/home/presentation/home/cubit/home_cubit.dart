import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/core/widgets/data.dart';
import 'package:healthy_sync/feature/patients/home/data/models/doctor_visit.dart';
import 'package:healthy_sync/feature/patients/home/presentation/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> loadProfile() async {
    emit(HomeLoading());
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      emit(HomeLoaded(
        profile: profile,
      ));
    } catch (e) {
      emit(HomeError('حدث خطأ أثناء تحميل الملف الشخصي'));
    }
  }

  Future<void> loadData() async {
    try {
      emit(HomeLoading());

      // Load all data in parallel
      await Future.wait([
        _loadSpecializations(),
        _loadDoctors(),
        _loadVisitData(),
      ]);

      emit(HomeLoaded(
        specializations: specializations,
        doctors: doctors,
        visitData: DoctorVisit.lastVisit,
      ));
    } catch (e) {
      log('Error loading data: $e');
      emit(HomeError(e.toString()));
    }
  }

  Future<void> refresh() async {
    try {
      emit(HomeLoading());

      // Load all data in parallel
      await Future.wait([
        _loadSpecializations(),
        _loadDoctors(),
        _loadVisitData(),
      ]);

      emit(HomeLoaded(
        specializations: specializations,
        doctors: doctors,
        visitData: DoctorVisit.lastVisit,
      ));
    } catch (e) {
      log('Error refreshing data: $e');
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _loadSpecializations() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      HomeLoaded(specializations: specializations);
    } catch (e) {
      log('Error loading specializations: $e');
      rethrow;
    }
  }

  Future<void> _loadDoctors() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      log('Error loading doctors: $e');
      rethrow;
    }
  }

  Future<void> _loadVisitData() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data is already in DoctorVisit.lastVisit
    } catch (e) {
      log('Error loading visit data: $e');
      rethrow;
    }
  }

  // Mock data
}
