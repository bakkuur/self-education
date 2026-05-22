import 'package:smart/domain/models/grade_row.dart';

abstract class GradeRepository {
  Stream<List<GradeRow>> getGrades();
}