part of 'xray_details_cubit.dart';

abstract class XrayDetailsState {}

class XrayDetailsInitial extends XrayDetailsState {}

class XrayDetailsLoading extends XrayDetailsState {}

class XrayDetailsLoaded extends XrayDetailsState {
  final Map<String, dynamic> xrayData;

  XrayDetailsLoaded({required this.xrayData});
}

class XrayDetailsError extends XrayDetailsState {
  final String message;

  XrayDetailsError(this.message);
}
