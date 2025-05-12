import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:healthy_sync/feature/doctors/home/data/patient_data.dart';

class LabTestPDF {
  final String testName;
  final String testType;
  final DateTime date;
  final String notes;
  final Patient patient;

  LabTestPDF({
    required this.testName,
    required this.testType,
    required this.date,
    required this.notes,
    required this.patient,
  });
}

class PDFService {
  static Future<File> generateLabTestPDF(LabTestPDF labTest) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              pw.SizedBox(height: 20),
              _buildPatientInfo(labTest.patient),
              pw.SizedBox(height: 20),
              _buildTestInfo(labTest),
              pw.SizedBox(height: 20),
              _buildNotes(labTest.notes),
              pw.SizedBox(height: 20),
              _buildFooter(),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File(
      '${output.path}/lab_test_${labTest.patient.id}_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildHeader() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          'تقرير تحليل طبي',
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          'Healthy Sync',
          style: pw.TextStyle(fontSize: 20, color: PdfColors.blue),
        ),
      ],
    );
  }

  static pw.Widget _buildPatientInfo(Patient patient) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'معلومات المريض',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 10),
          pw.Text('الاسم: ${patient.name}'),
          pw.Text('العمر: ${patient.age} سنة'),
          pw.Text('رقم الهاتف: ${patient.phone}'),
        ],
      ),
    );
  }

  static pw.Widget _buildTestInfo(LabTestPDF labTest) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'تفاصيل التحليل',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 10),
          pw.Text('نوع التحليل: ${labTest.testType}'),
          pw.Text('اسم التحليل: ${labTest.testName}'),
          pw.Text('التاريخ: ${labTest.date.toString().split(' ')[0]}'),
        ],
      ),
    );
  }

  static pw.Widget _buildNotes(String notes) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'ملاحظات',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 10),
          pw.Text(notes),
        ],
      ),
    );
  }

  static pw.Widget _buildFooter() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          'تم التوقيع',
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          'التاريخ: ${DateTime.now().toString().split(' ')[0]}',
          style: pw.TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
