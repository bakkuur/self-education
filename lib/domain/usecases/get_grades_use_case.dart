import 'package:smart/domain/repositories/grade_repository.dart';
import 'package:smart/domain/models/grade_row.dart';

class GetGradesUseCase {
  final GradeRepository repository;

  GetGradesUseCase(this.repository);

  Stream<List<GradeRow>> execute() => repository.getGrades();
}