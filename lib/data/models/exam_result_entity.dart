import 'package:smart/domain/models/exam_result.dart';

class ExamResultEntity {
  final String id;
  final String studentId;
  final String subjectId;
  final String unitId;
  final int score;
  final int total;
  final DateTime date;

  ExamResultEntity({
    required this.id,
    required this.studentId,
    required this.subjectId,
    required this.unitId,
    required this.score,
    required this.total,
    required this.date,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'studentId': studentId,
      'subjectId': subjectId,
      'unitId': unitId,
      'score': score,
      'total': total,
      'date': date.toIso8601String(),
    };
  }

  factory ExamResultEntity.fromFirestore(Map<String, dynamic> data, String id) {
    return ExamResultEntity(
      id: id,
      studentId: data['studentId'],
      subjectId: data['subjectId'],
      unitId: data['unitId'],
      score: data['score'],
      total: data['total'],
      date: DateTime.parse(data['date']),
    );
  }

  ExamResult toDomain() {
    return ExamResult(
      id: id,
      studentId: studentId,
      subjectId: subjectId,
      unitId: unitId,
      score: score,
      total: total,
      date: date,
    );
  }
}