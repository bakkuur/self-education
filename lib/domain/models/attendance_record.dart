class AttendanceRecord {
  final String id;
  final String studentId;
  final DateTime date;
  final bool isPresent;
  final String? note;

  const AttendanceRecord({
    required this.id,
    required this.studentId,
    required this.date,
    required this.isPresent,
    this.note,
  });
}