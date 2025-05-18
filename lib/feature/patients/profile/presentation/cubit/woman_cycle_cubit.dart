import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';

part 'woman_cycle_state.dart';

class WomanCycleCubit extends Cubit<WomanCycleState> {
  WomanCycleCubit() : super(WomanCycleInitial());

  Future<void> loadSettings() async {
    emit(WomanCycleLoading());
    try {
      log('Loading cycle length...');
      final loadedCycleLength =
          await SharedHelper.get(SharedKeys.cycleLength) as int? ?? 28;
      log('Cycle length loaded: $loadedCycleLength');

      log('Loading period length...');
      final loadedPeriodLength =
          await SharedHelper.get(SharedKeys.periodLength) as int? ?? 7;
      log('Period length loaded: $loadedPeriodLength');

      log('Loading ovulation day...');
      final loadedOvulationDay =
          await SharedHelper.get(SharedKeys.ovulationDay) as int? ?? 14;
      log('Ovulation day loaded: $loadedOvulationDay');

      log('Loading ovulation length...');
      final loadedOvulationLength =
          await SharedHelper.get(SharedKeys.ovulationLength) as int? ?? 5;
      log('Ovulation length loaded: $loadedOvulationLength');

      log('Loading start date...');
      final loadedStartDate =
          await SharedHelper.get(SharedKeys.startDate) as String?;
      log('Start date loaded: $loadedStartDate');

      log('Loading cycle history...');
      final loadedCycleHistory =
          await SharedHelper.get(SharedKeys.cycleHistory) as List<String>? ??
              [];
      log('Cycle history loaded: $loadedCycleHistory');

      emit(WomanCycleLoaded(
        startDate:
            loadedStartDate != null ? DateTime.parse(loadedStartDate) : null,
        cycleLength: loadedCycleLength,
        periodLength: loadedPeriodLength,
        ovulationDay: loadedOvulationDay,
        ovulationLength: loadedOvulationLength,
        cycleHistory:
            loadedCycleHistory.map((date) => DateTime.parse(date)).toList(),
      ));
      log('Settings loaded successfully');
    } catch (e, stackTrace) {
      log('Error loading settings: $e');
      log('Stack trace: $stackTrace');
      emit(WomanCycleError('Failed to load settings'));
    }
  }

  Future<void> updateSettings({
    required int cycleLength,
    required int periodLength,
    required int ovulationDay,
    required int ovulationLength,
  }) async {
    emit(WomanCycleLoading());
    try {
      await SharedHelper.sava(SharedKeys.cycleLength, cycleLength);
      await SharedHelper.sava(SharedKeys.periodLength, periodLength);
      await SharedHelper.sava(SharedKeys.ovulationDay, ovulationDay);
      await SharedHelper.sava(SharedKeys.ovulationLength, ovulationLength);

      emit(WomanCycleSuccess('Settings updated successfully'));
      await loadSettings();
    } catch (e) {
      log('Error updating settings: $e');
      emit(WomanCycleError('Failed to update settings'));
    }
  }

  Future<void> registerNewCycle(DateTime startDate) async {
    try {
      log('Starting to register new cycle...');
      log('Current state: $state');
      final currentState = state;
      if (currentState is WomanCycleLoaded) {
        log('Current state is loaded, updating cycle history...');
        final updatedHistory = [...currentState.cycleHistory, startDate];
        log('Updated history: $updatedHistory');

        log('Saving cycle history...');
        final historyResult = await SharedHelper.sava(
          SharedKeys.cycleHistory,
          updatedHistory.map((date) => date.toIso8601String()).toList(),
        );
        log('History save result: $historyResult');

        log('Saving start date...');
        final startDateResult = await SharedHelper.sava(
          SharedKeys.startDate,
          startDate.toIso8601String(),
        );
        log('Start date save result: $startDateResult');

        log('Cycle registered successfully, reloading settings...');
        await loadSettings();
      } else {
        log('Current state is not loaded, cannot register cycle');
        emit(WomanCycleError('Cannot register cycle in current state'));
      }
    } catch (e, stackTrace) {
      log('Error registering new cycle: $e');
      log('Stack trace: $stackTrace');
      emit(WomanCycleError('Failed to register new cycle'));
    }
  }

  String getDayType(int dayIndex) {
    final currentState = state;
    if (currentState is WomanCycleLoaded) {
      if (dayIndex < currentState.periodLength) {
        return 'فترة الحيض';
      } else if (dayIndex == currentState.ovulationDay) {
        return 'يوم التبويض';
      } else if (dayIndex >=
              currentState.ovulationDay - currentState.ovulationLength + 2 &&
          dayIndex <= currentState.ovulationDay + 1) {
        return 'فترة التبويض';
      } else if (dayIndex >= currentState.cycleLength - 5) {
        return 'قبل الدورة';
      }
      return 'بعد الدورة';
    }
    return '';
  }

  Color getDayColor(int index) {
    final currentState = state;
    if (currentState is WomanCycleLoaded) {
      if (index < currentState.periodLength) return Colors.pink[200]!;
      if (index == currentState.ovulationDay) return Colors.amberAccent;
      if (index >=
              currentState.ovulationDay - currentState.ovulationLength + 2 &&
          index <= currentState.ovulationDay + 1) {
        return Colors.lightGreen;
      }
      if (index >= currentState.cycleLength - 5) return Colors.deepOrangeAccent;
    }
    return Colors.grey[300]!;
  }

  List<DateTime> generateCycleDays() {
    final currentState = state;
    if (currentState is WomanCycleLoaded && currentState.startDate != null) {
      return List.generate(
        currentState.ovulationDay + 3,
        (index) => currentState.startDate!.add(Duration(days: index)),
      );
    }
    return [];
  }
}
