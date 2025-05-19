part of 'xray_tests_cubit.dart';

abstract class XrayTestsState {}

class XrayTestsInitial extends XrayTestsState {}

class XrayTestsLoading extends XrayTestsState {}

class XrayTestsLoaded extends XrayTestsState {
  final List<Map<String, dynamic>> xrayTests;
  final String? filterPeriod;

  XrayTestsLoaded({required this.xrayTests, this.filterPeriod});
}

class XrayTestsError extends XrayTestsState {
  final String message;

  XrayTestsError(this.message);
}
