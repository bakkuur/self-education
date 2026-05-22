class ExamResult {
  final String id;
  final String studentId;
  final String subjectId;
  final String unitId;
  final int score;
  final int total;
  final DateTime date;

  const ExamResult({
    required this.id,
    required this.studentId,
    required this.subjectId,
    required this.unitId,
    required this.score,
    required this.total,
    required this.date,
  });

  double get percentage => total > 0 ? score / total : 0.0;
}