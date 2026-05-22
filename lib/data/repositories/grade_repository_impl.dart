
import 'package:smart/domain/models/grade_row.dart';
import 'package:smart/domain/repositories/grade_repository.dart';
// import 'package:smart/data/datasources/remote/mock_data_service.dart';

class GradeRepositoryImpl implements GradeRepository {
  final MockDataService mockDataService;

  GradeRepositoryImpl(this.mockDataService);

  @override
  Stream<List<GradeRow>> getGrades() async* {
    await Future.delayed(const Duration(milliseconds: 400));
    yield mockDataService.getGrades();
  }
}

class MockDataService {
  getGrades() {}

  getSubjects() {}

  getUnits(String subjectId) {}
}