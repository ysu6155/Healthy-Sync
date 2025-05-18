part of 'woman_cycle_cubit.dart';

abstract class WomanCycleState {
  List<Object?> get props => [];
}

class WomanCycleInitial extends WomanCycleState {}

class WomanCycleLoading extends WomanCycleState {}

class WomanCycleLoaded extends WomanCycleState {
  final DateTime? startDate;
  final int cycleLength;
  final int periodLength;
  final int ovulationDay;
  final int ovulationLength;
  final List<DateTime> cycleHistory;

  WomanCycleLoaded({
    this.startDate,
    required this.cycleLength,
    required this.periodLength,
    required this.ovulationDay,
    required this.ovulationLength,
    required this.cycleHistory,
  });

  List<DateTime> generateCycleDays() {
    if (startDate == null) return [];
    return List.generate(
      ovulationDay + 3,
      (index) => startDate!.add(Duration(days: index)),
    );
  }

  @override
  List<Object?> get props => [
        startDate,
        cycleLength,
        periodLength,
        ovulationDay,
        ovulationLength,
        cycleHistory,
      ];
}

class WomanCycleError extends WomanCycleState {
  final String message;
  WomanCycleError(this.message);

  @override
  List<Object?> get props => [message];
}

class WomanCycleSuccess extends WomanCycleState {
  final String message;
  WomanCycleSuccess(this.message);

  @override
  List<Object> get props => [message];
}
