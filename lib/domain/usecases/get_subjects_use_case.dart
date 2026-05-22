import 'package:smart/domain/repositories/subject_repository.dart';
import 'package:smart/domain/models/school_subject.dart';

class GetSubjectsUseCase {
  final SubjectRepository repository;

  GetSubjectsUseCase(this.repository);

  Stream<List<SchoolSubject>> execute() => repository.getSubjects();
}