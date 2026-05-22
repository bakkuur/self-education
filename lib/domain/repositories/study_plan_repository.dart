import 'package:smart/domain/models/task.dart';

abstract class StudyPlanRepository {
  Stream<List<Task>> getTodayTasks();
  Future<void> updateTaskCompletion(String taskId, bool isCompleted);
}