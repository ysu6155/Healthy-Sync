import 'package:equatable/equatable.dart';

abstract class SpecializationsState extends Equatable {
  const SpecializationsState();

  @override
  List<Object?> get props => [];
}

class SpecializationsInitial extends SpecializationsState {}

class SpecializationsLoading extends SpecializationsState {}

class SpecializationsLoaded extends SpecializationsState {
  final List<Map<String, dynamic>> specializations;
  final String? searchQuery;

  const SpecializationsLoaded({
    required this.specializations,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [specializations, searchQuery];
}

class SpecializationsError extends SpecializationsState {
  final String message;

  const SpecializationsError({required this.message});

  @override
  List<Object?> get props => [message];
}
