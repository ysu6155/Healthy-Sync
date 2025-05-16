class Appointment {
  final String? id;
  final String? patientId;
  final String? doctorId;
  final DateTime? date;
  final String? time;
  final String? status; // 'available', 'booked', 'completed', 'cancelled'
  final String? type; // 'كشف جديد', 'متابعة', 'تحليل', 'إلخ'
  final String? notes;

  Appointment({
    this.id,
    this.patientId,
    this.doctorId,
    this.date,
    this.time,
    this.status,
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
    doctorId: '1',
    date: DateTime(2024, 3, 20),
    time: '10:00 ص',
    status: 'booked',
    type: 'كشف جديد',
    notes: 'متابعة حالة القلب',
  ),
  Appointment(
    id: '2',
    patientId: '2',
    doctorId: '1',
    date: DateTime(2024, 3, 20),
    time: '11:30 ص',
    status: 'booked',
    type: 'متابعة',
    notes: 'متابعة التحاليل',
  ),
  Appointment(
    id: '3',
    patientId: '3',
    doctorId: '1',
    date: DateTime(2024, 3, 20),
    time: '01:00 م',
    status: 'available',
    type: 'كشف جديد',
  ),
];
