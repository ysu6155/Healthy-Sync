import 'package:flutter_bloc/flutter_bloc.dart';

part 'treatment_schedule_state.dart';

class TreatmentScheduleCubit extends Cubit<TreatmentScheduleState> {
  TreatmentScheduleCubit() : super(TreatmentScheduleInitial());

  Future<void> loadSchedules() async {
    emit(TreatmentScheduleLoading());
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      final schedules = [
        {
          
          'id': '1',
          'name': '25 وحدة السولين',
          'time': '09:00',
          'taken': false,
          'remaining': 10,
          'lastTaken': null,
          'type': 'medication',
          'medicationType': 'حقنة',
        },
        {
          'id': '2',
          'name': 'برندوبريل 10 مع',
          'time': '19:00',
          'taken': false,
          'remaining': 10,
          'lastTaken': null,
          'type': 'medication',
          'medicationType': 'حبوب',
        },
        {
          'id': '3',
          'name': 'املودويني 5 مع',
          'time': '19:00',
          'taken': true,
          'remaining': 10,
          'lastTaken': DateTime.now(),
          'type': 'medication',
          'medicationType': 'حبوب',
        },
        {
          'id': '4',
          'name': 'فوروسيميد 20 مع',
          'time': '19:00',
          'taken': false,
          'remaining': 10,
          'lastTaken': null,
          'type': 'medication',
          'medicationType': 'حبوب',
        },
        {
          'id': '5',
          'name': 'اسبرين 81 مع',
          'time': '19:00',
          'taken': false,
          'remaining': 10,
          'lastTaken': null,
          'type': 'medication',
          'medicationType': 'حبوب',
        },
        {
          'id': '6',
          'name': 'تحليل سكر تراكمي',
          'date': '2023-12-15',
          'done': false,
          'type': 'test',
        },
        {
          'id': '7',
          'name': 'تحليل وظائف كبد',
          'date': '2023-12-20',
          'done': true,
          'type': 'test',
        },
        {
          'id': '8',
          'name': 'تحليل وظائف كلى',
          'date': '2023-12-25',
          'done': false,
          'type': 'test',
        },
        {
          'id': '9',
          'name': 'تحليل دهون ثلاثية',
          'date': '2023-12-30',
          'done': true,
          'type': 'test',
        },
        {
          'id': '10',
          'name': 'تحليل كوليسترول',
          'date': '2023-12-31',
          'done': false,
          'type': 'test',
        },
        {
          'id': '11',
          'name': 'تحليل فيتامين د',
          'date': '2023-12-31',
          'done': false,
          'type': 'test',
        },
        {
          'id': '12',
          'name': 'تحليل فيتامين ب12',
          'date': '2023-12-31',
          'done': false,
          'type': 'test',
        },
        {
          'id': '13',
          'name': 'تحليل CBC',
          'date': '2023-12-31',
          'done': false,
          'type': 'test',
        },
        {
          'id': '14',
          'name': 'تحليل CRP',
          'date': '2023-12-31',
          'done': false,
          'type': 'test',
        },
      ];

      emit(TreatmentScheduleLoaded(schedules: schedules));
    } catch (e) {
      emit(TreatmentScheduleError('حدث خطأ أثناء تحميل جدول العلاج'));
    }
  }

  Future<void> refresh() async {
    if (state is TreatmentScheduleLoaded) {
      final currentSchedules = (state as TreatmentScheduleLoaded).schedules;
      emit(TreatmentScheduleLoading());
      try {
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 1));
        emit(TreatmentScheduleLoaded(schedules: currentSchedules));
      } catch (e) {
        emit(TreatmentScheduleError('حدث خطأ أثناء تحديث جدول العلاج'));
      }
    }
  }

  Future<void> markAsCompleted(String scheduleId) async {
    if (state is TreatmentScheduleLoaded) {
      final currentSchedules = (state as TreatmentScheduleLoaded).schedules;
      emit(TreatmentScheduleLoading());
      try {
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 1));

        // Update the schedule status
        final updatedSchedules = currentSchedules.map((schedule) {
          if (schedule['id'] == scheduleId) {
            if (schedule['type'] == 'medication') {
              return {
                ...schedule,
                'taken': true,
                'lastTaken': DateTime.now(),
                'remaining': (schedule['remaining'] as int) - 1,
              };
            } else {
              return {
                ...schedule,
                'done': true,
              };
            }
          }
          return schedule;
        }).toList();

        emit(TreatmentScheduleLoaded(schedules: updatedSchedules));
      } catch (e) {
        emit(TreatmentScheduleError('حدث خطأ أثناء تحديث حالة الجدول'));
      }
    }
  }
}
