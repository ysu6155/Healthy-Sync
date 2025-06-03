import 'package:healthy_sync/core/widgets/data.dart';

class LabTestPDF {
  final String testName;
  final String testType;
  final DateTime date;
  final String notes;
  final Patient patient;
  final String? imagePath;

  LabTestPDF({
    required this.testName,
    required this.testType,
    required this.date,
    required this.notes,
    required this.patient,
    this.imagePath,
  });
}
