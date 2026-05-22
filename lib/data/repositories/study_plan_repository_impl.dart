import 'package:smart/domain/models/task.dart';
import 'package:smart/domain/repositories/study_plan_repository.dart';

class StudyPlanRepositoryImpl implements StudyPlanRepository {
  // بيانات تجريبية مؤقتة
  static final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'مادة: رياضيات - الوحدة 1',
      description: 'تمارين الجمع والطرح',
      dueDate: DateTime.now(),
      isCompleted: true,
      subjectId: 'math',
    ),
    Task(
      id: '2',
      title: 'مادة: علوم - الوحدة 2',
      description: 'قراءة الدرس + أسئلة المراجعة',
      dueDate: DateTime.now(),
      isCompleted: false,
      subjectId: 'science',
    ),
    Task(
      id: '3',
      title: 'مادة: لغة عربية - النص الأدبي',
      description: 'حفظ المفردات',
      dueDate: DateTime.now(),
      isCompleted: true,
      subjectId: 'arabic',
    ),
    Task(
      id: '4',
      title: 'مادة: قرآن كريم - سورة الناس',
      description: 'مراجعة التلاوة',
      dueDate: DateTime.now(),
      isCompleted: false,
      subjectId: 'quran',
    ),
    Task(
      id: '5',
      title: 'مادة: إنجليزي - Unit 3',
      description: 'Grammar worksheet',
      dueDate: DateTime.now(),
      isCompleted: false,
      subjectId: 'english',
    ),
  ];

  @override
  Stream<List<Task>> getTodayTasks() async* {
    yield _tasks;
  }

  @override
  Future<void> updateTaskCompletion(String taskId, bool isCompleted) async {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(isCompleted: isCompleted);
    }
  }
}