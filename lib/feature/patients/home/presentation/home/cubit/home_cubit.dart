import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/feature/doctors/home/data/data.dart';
import 'package:healthy_sync/feature/patients/home/data/models/doctor_visit.dart';
import 'package:healthy_sync/feature/patients/home/presentation/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Future<void> loadData() async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      // Load all data in parallel
      await Future.wait([
        _loadSpecializations(),
        _loadDoctors(),
        _loadVisitData(),
      ]);

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      log('Error loading data: $e');
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> refresh() async {
    try {
      emit(state.copyWith(isRefreshing: true, error: null));

      // Load all data in parallel
      await Future.wait([
        _loadSpecializations(),
        _loadDoctors(),
        _loadVisitData(),
      ]);

      emit(state.copyWith(isRefreshing: false));
    } catch (e) {
      log('Error refreshing data: $e');
      emit(state.copyWith(
        isRefreshing: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _loadSpecializations() async {
    try {
      emit(state.copyWith(isSpecializationsLoading: true));

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data

      emit(state.copyWith(
        isSpecializationsLoading: false,
        specializations: specializations,
      ));
    } catch (e) {
      log('Error loading specializations: $e');
      emit(state.copyWith(
        isSpecializationsLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _loadDoctors() async {
    try {
      emit(state.copyWith(isDoctorsLoading: true));

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      

      emit(state.copyWith(
        isDoctorsLoading: false,
        doctors: doctors,
      ));
    } catch (e) {
      log('Error loading doctors: $e');
      emit(state.copyWith(
        isDoctorsLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _loadVisitData() async {
    try {
      emit(state.copyWith(isVisitLoading: true));

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
    

      emit(state.copyWith(
        isVisitLoading: false,
        visitData: DoctorVisit.lastVisit,
      ));
    } catch (e) {
      log('Error loading visit data: $e');
      emit(state.copyWith(
        isVisitLoading: false,
        error: e.toString(),
      ));
    }
  }
}
