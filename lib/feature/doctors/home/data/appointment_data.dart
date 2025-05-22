enum AppointmentStatus {
  scheduled,
  completed,
  cancelled,
}

class Appointment {
  final String id;
  final String patientId;
  final String patientName;
  final DateTime date;
  final String time;
  final AppointmentStatus status;
  final String? doctorId;
  final String? type; // 'كشف جديد', 'متابعة', 'تحليل', 'إلخ'
  final String? notes;

  const Appointment({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.date,
    required this.time,
    required this.status,
    this.doctorId,
    this.type,
    this.notes,
  });
}

// Available time slots for appointments
final List<String> availableTimes = [
  '09:00 ص',
  '09:30 ص',
  '10:00 ص',
  '10:30 ص',
  '11:00 ص',
  '11:30 ص',
  '12:00 م',
  '12:30 م',
  '01:00 م',
  '01:30 م',
  '02:00 م',
  '02:30 م',
  '03:00 م',
  '03:30 م',
  '04:00 م',
  '04:30 م',
];

// Sample appointments
final List<Appointment> appointments = [
  Appointment(
    id: '1',
    patientId: '1',
    patientName: 'John Doe',
    date: DateTime(2024, 3, 20),
    time: '10:00 ص',
    status: AppointmentStatus.scheduled,
    doctorId: '1',
    type: 'كشف جديد',
    notes: 'متابعة حالة القلب',
  ),
  Appointment(
    id: '2',
    patientId: '01090438632',
    patientName: 'Jane Doe',
    date: DateTime(2024, 3, 20),
    time: '11:30 ص',
    status: AppointmentStatus.scheduled,
    doctorId: '1',
    type: 'متابعة',
    notes: 'متابعة التحاليل',
  ),
  Appointment(
    id: '3',
    patientId: '3',
    patientName: 'Bob Smith',
    date: DateTime(2024, 3, 20),
    time: '01:00 م',
    status: AppointmentStatus.scheduled,
    doctorId: '1',
    type: 'كشف جديد',
  ),
];
