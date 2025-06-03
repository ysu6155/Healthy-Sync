abstract class ChronicDiseasesState {}

class ChronicDiseasesInitial extends ChronicDiseasesState {}

class ChronicDiseasesLoading extends ChronicDiseasesState {}

class ChronicDiseasesSuccess extends ChronicDiseasesState {
  final String message;
  ChronicDiseasesSuccess(this.message);
}

class ChronicDiseasesError extends ChronicDiseasesState {
  final String message;
  ChronicDiseasesError(this.message);
} 