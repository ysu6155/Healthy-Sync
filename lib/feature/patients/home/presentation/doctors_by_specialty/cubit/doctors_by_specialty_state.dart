import 'package:equatable/equatable.dart';

abstract class DoctorsBySpecialtyState extends Equatable {
  const DoctorsBySpecialtyState();

  @override
  List<Object?> get props => [];
}

class DoctorsBySpecialtyInitial extends DoctorsBySpecialtyState {}

class DoctorsBySpecialtyLoading extends DoctorsBySpecialtyState {}

class DoctorsBySpecialtyLoaded extends DoctorsBySpecialtyState {
  final List<Map<String, dynamic>> doctors;
  final String specialty;

  const DoctorsBySpecialtyLoaded({
    required this.doctors,
    required this.specialty,
  });

  @override
  List<Object?> get props => [doctors, specialty];
}

class DoctorsBySpecialtyError extends DoctorsBySpecialtyState {
  final String message;

  const DoctorsBySpecialtyError({required this.message});

  @override
  List<Object?> get props => [message];
}
