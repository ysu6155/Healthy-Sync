import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/core/service/local/shared_helper.dart';
import 'package:healthy_sync/core/service/local/shared_keys.dart';
import 'package:healthy_sync/feature/patients/profile/presentation/woman_cycle/cubit/woman_cycle_state.dart';

class WomanCycleCubit extends Cubit<WomanCycleState> {
  WomanCycleCubit() : super(const WomanCycleInitial()) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    try {
      emit(const WomanCycleLoading());

      final settings = {
        'cycleLength': await _getIntValue(SharedKeys.cycleLength, 28),
        'periodLength': await _getIntValue(SharedKeys.periodLength, 7),
        'ovulationDay': await _getIntValue(SharedKeys.ovulationDay, 14),
        'ovulationLength': await _getIntValue(SharedKeys.ovulationLength, 5),
      };

      emit(WomanCycleLoaded(settings: settings));
    } catch (e) {
      emit(WomanCycleError(e.toString()));
    }
  }

  Future<int> _getIntValue(String key, int defaultValue) async {
    try {
      final value = await SharedHelper.get(key);
      if (value == null) return defaultValue;
      if (value is int) return value;
      if (value is String) {
        return int.tryParse(value) ?? defaultValue;
      }
      return defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  Future<void> updateSettings({
    int? cycleLength,
    int? periodLength,
    int? ovulationLength,
  }) async {
    try {
      final currentState = state;
      if (currentState is WomanCycleLoaded) {
        final settings = Map<String, dynamic>.from(currentState.settings);

        if (cycleLength != null) {
          settings['cycleLength'] = cycleLength;
          await SharedHelper.sava(SharedKeys.cycleLength, cycleLength);
        }

        if (periodLength != null) {
          settings['periodLength'] = periodLength;
          await SharedHelper.sava(SharedKeys.periodLength, periodLength);
        }

        if (ovulationLength != null) {
          settings['ovulationLength'] = ovulationLength;
          await SharedHelper.sava(SharedKeys.ovulationLength, ovulationLength);
        }

        emit(WomanCycleLoaded(settings: settings));
      }
    } catch (e) {
      emit(WomanCycleError(e.toString()));
    }
  }

  Color getDayColor(int index) {
    if (state is! WomanCycleLoaded) return Colors.grey[300]!;

    final settings = (state as WomanCycleLoaded).settings;
    final periodLength = settings['periodLength'] as int;
    final ovulationDay = settings['ovulationDay'] as int;
    final ovulationLength = settings['ovulationLength'] as int;
    final cycleLength = settings['cycleLength'] as int;

    if (index < periodLength) return Colors.pink[200]!;
    if (index == ovulationDay) return Colors.amberAccent;
    if (index >= ovulationDay - ovulationLength + 2 &&
        index <= ovulationDay + 1) {
      return Colors.lightGreen;
    }
    if (index >= cycleLength - 5) return Colors.deepOrangeAccent;
    return Colors.grey[300]!;
  }

  String getDayType(int index) {
    if (state is! WomanCycleLoaded) return 'يوم عادي';

    final settings = (state as WomanCycleLoaded).settings;
    final periodLength = settings['periodLength'] as int;
    final ovulationDay = settings['ovulationDay'] as int;
    final cycleLength = settings['cycleLength'] as int;

    if (index < periodLength) return 'فترة الدورة';
    if (index == ovulationDay) return 'أفضل يوم تبويض';
    if (index >= ovulationDay - 3 && index <= ovulationDay + 1)
      return 'فترة التبويض';
    if (index >= cycleLength - 5) return 'قبل الدورة';
    return 'يوم عادي';
  }
}
