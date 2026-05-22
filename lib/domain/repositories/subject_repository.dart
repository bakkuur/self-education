import 'package:smart/domain/models/school_subject.dart';
import 'package:smart/domain/models/unit.dart';

abstract class SubjectRepository {
  Stream<List<SchoolSubject>> getSubjects();
  Stream<List<Unit>> getUnits(String subjectId);
  Future<Unit?> getUnit(String unitId);
  Future<void> updateUnitProgress(String unitId, double progress);
}