import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_sync/feature/patients/medical_tests/data/dummy_data.dart';

part 'xray_tests_state.dart';

class XrayTestsCubit extends Cubit<XrayTestsState> {
  XrayTestsCubit() : super(XrayTestsInitial());

  Future<void> loadData() async {
    emit(XrayTestsLoading());
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      final xrayTests = MedicalTestsData.getRecentXrayTests();
      emit(XrayTestsLoaded(xrayTests: xrayTests));
    } catch (e) {
      emit(XrayTestsError('Failed to load X-ray tests'));
    }
  }

  Future<void> filterByPeriod(String period,
      [DateTime? startDate, DateTime? endDate]) async {
    if (state is XrayTestsLoaded) {
      final allTests = MedicalTestsData.getRecentXrayTests();
      final now = DateTime.now();

      final filteredTests = allTests.where((test) {
        final testDate = DateTime.parse(test['date']);
        if (period == '3_months') {
          final threeMonthsAgo = DateTime(now.year, now.month - 3, now.day);
          return testDate.isAfter(threeMonthsAgo);
        } else if (period == 'this_year') {
          return testDate.year == now.year;
        } else if (period == '6_months') {
          final sixMonthsAgo = DateTime(now.year, now.month - 6, now.day);
          return testDate.isAfter(sixMonthsAgo);
        } else if (period == 'custom' && startDate != null && endDate != null) {
          // Add one day to endDate to include the end date in the range
          final adjustedEndDate = endDate.add(const Duration(days: 1));
          return testDate.isAfter(startDate) &&
              testDate.isBefore(adjustedEndDate);
        }
        return true;
      }).toList();

      emit(XrayTestsLoaded(xrayTests: filteredTests, filterPeriod: period));
    }
  }

  Future<void> clearFilter() async {
    if (state is XrayTestsLoaded) {
      final allTests = MedicalTestsData.getRecentXrayTests();
      emit(XrayTestsLoaded(xrayTests: allTests));
    }
  }

  Future<void> refresh() async {
    await loadData();
  }
}
