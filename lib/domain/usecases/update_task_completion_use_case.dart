import 'package:smart/domain/repositories/study_plan_repository.dart';

class UpdateTaskCompletionUseCase {
  final StudyPlanRepository repository;

  UpdateTaskCompletionUseCase(this.repository);

  Future<void> execute(String taskId, bool isCompleted) async {
    await repository.updateTaskCompletion(taskId, isCompleted);
  }
}