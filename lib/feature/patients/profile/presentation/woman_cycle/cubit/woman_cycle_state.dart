import 'package:equatable/equatable.dart';

abstract class WomanCycleState extends Equatable {
  const WomanCycleState();

  @override
  List<Object?> get props => [];
}

class WomanCycleInitial extends WomanCycleState {
  const WomanCycleInitial();
}

class WomanCycleLoading extends WomanCycleState {
  const WomanCycleLoading();
}

class WomanCycleLoaded extends WomanCycleState {
  final Map<String, dynamic> settings;

  const WomanCycleLoaded({required this.settings});

  @override
  List<Object?> get props => [settings];
}

class WomanCycleError extends WomanCycleState {
  final String message;

  const WomanCycleError(this.message);

  @override
  List<Object?> get props => [message];
}
