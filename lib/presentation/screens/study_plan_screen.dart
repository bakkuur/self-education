import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanTask {
  const PlanTask({required this.title, required this.subtitle});
  final String title;
  final String subtitle;
}

class StudyPlanScreen extends StatefulWidget {
  const StudyPlanScreen({super.key});

  @override
  State<StudyPlanScreen> createState() => _StudyPlanScreenState();
}

class _StudyPlanScreenState extends State<StudyPlanScreen> {
  late List<bool> _completed;

  static const List<PlanTask> _tasks = [
    PlanTask(title: 'مادة: رياضيات - الوحدة 1', subtitle: 'تمارين الجمع والطرح'),
    PlanTask(title: 'مادة: علوم - الوحدة 2', subtitle: 'قراءة الدرس + أسئلة المراجعة'),
    PlanTask(title: 'مادة: لغة عربية - النص الأدبي', subtitle: 'حفظ المفردات'),
    PlanTask(title: 'مادة: قرآن كريم - سورة الناس', subtitle: 'مراجعة التلاوة'),
    PlanTask(title: 'مادة: إنجليزي - Unit 3', subtitle: 'Grammar worksheet'),
  ];

  @override
  void initState() {
    super.initState();
    _completed = List<bool>.filled(_tasks.length, false);
    _completed[0] = true;
    _completed[2] = true;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('الخطة الدراسية', style: GoogleFonts.tajawal(fontWeight: FontWeight.w700)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _tasks.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final task = _tasks[index];
          final completed = _completed[index];
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: completed ? scheme.tertiary : scheme.outlineVariant, width: 1),
            ),
            color: completed ? scheme.tertiaryContainer : scheme.surfaceContainerHighest,
            child: CheckboxListTile(
              value: completed,
              onChanged: (val) => setState(() => _completed[index] = val ?? false),
              title: Text(
                task.title,
                style: GoogleFonts.tajawal(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  decoration: completed ? TextDecoration.lineThrough : null,
                  color: completed ? scheme.onTertiaryContainer : scheme.onSurface,
                ),
              ),
              subtitle: Text(
                task.subtitle,
                style: GoogleFonts.tajawal(fontSize: 13, color: scheme.onSurfaceVariant),
              ),
              activeColor: scheme.tertiary,
              checkColor: scheme.onTertiary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          );
        },
      ),
    );
  }
}