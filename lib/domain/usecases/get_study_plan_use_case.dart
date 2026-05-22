import 'package:smart/domain/repositories/study_plan_repository.dart';
import 'package:smart/domain/models/task.dart';

class GetStudyPlanUseCase {
  final StudyPlanRepository repository;

  GetStudyPlanUseCase(this.repository);

  Stream<List<Task>> execute() => repository.getTodayTasks();
}