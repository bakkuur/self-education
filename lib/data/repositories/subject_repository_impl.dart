import 'package:smart/data/repositories/grade_repository_impl.dart';
import 'package:smart/domain/models/school_subject.dart';
import 'package:smart/domain/models/unit.dart';
import 'package:smart/domain/repositories/subject_repository.dart';
// import 'package:smart/data/datasources/remote/mock_data_service.dart';

class SubjectRepositoryImpl implements SubjectRepository {
  final MockDataService mockDataService;

  SubjectRepositoryImpl(this.mockDataService);

  @override
  Stream<List<SchoolSubject>> getSubjects() async* {
    // محاكاة تأخير الشبكة
    await Future.delayed(const Duration(milliseconds: 500));
    yield mockDataService.getSubjects();
  }

  @override
  Stream<List<Unit>> getUnits(String subjectId) async* {
    await Future.delayed(const Duration(milliseconds: 300));
    yield mockDataService.getUnits(subjectId);
  }

  @override
  Future<Unit?> getUnit(String unitId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // يمكن البحث عن الوحدة من البيانات التجريبية
    return null;
  }

  @override
  Future<void> updateUnitProgress(String unitId, double progress) async {
    // سيتم تنفيذها لاحقاً مع SharedPreferences
    await Future.delayed(const Duration(milliseconds: 200));
  }
}