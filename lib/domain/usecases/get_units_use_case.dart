import 'package:smart/domain/repositories/subject_repository.dart';
import 'package:smart/domain/models/unit.dart';

class GetUnitsUseCase {
  final SubjectRepository repository;

  GetUnitsUseCase(this.repository);

  Stream<List<Unit>> execute(String subjectId) => repository.getUnits(subjectId);
}