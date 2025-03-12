part of 'profile_cubit.dart';

abstract class ProfileState {
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String email;
  final String image;
  final String? phone;
  final String? address;
  final String? city;

  ProfileLoaded({
    required this.name,
    required this.email,
    required this.image,
    this.address,
    this.city,
    this.phone,
  });

  @override
  List<Object?> get props => [name, email, image];
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileSuccess extends ProfileState {
  final String message;

  ProfileSuccess(this.message);

  @override
  List<Object> get props => [message];
}
class ProfileUpdateError extends ProfileState {
  final String message;
  ProfileUpdateError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileUpdateSuccess extends ProfileState {
  final String message;

  ProfileUpdateSuccess(this.message);

  @override
  List<Object> get props => [message];
}
class ProfileUpdateLoading extends ProfileState {}
