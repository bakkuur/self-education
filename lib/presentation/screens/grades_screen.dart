import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart/domain/models/grade_row.dart';

class GradesScreen extends StatelessWidget {
  const GradesScreen({super.key});

  static const List<GradeRow> _grades = [
    GradeRow(subject: 'الرياضيات', score: 92, max: 100, color: Color(0xFF5C6BC0)),
    GradeRow(subject: 'العلوم', score: 88, max: 100, color: Color(0xFF26A69A)),
    GradeRow(subject: 'التربية الإسلامية', score: 95, max: 100, color: Color(0xFF7E57C2)),
    GradeRow(subject: 'القرآن الكريم', score: 90, max: 100, color: Color(0xFF43A047)),
    GradeRow(subject: 'اللغة العربية', score: 85, max: 100, color: Color(0xFFE53935)),
    GradeRow(subject: 'اللغة الإنجليزية', score: 78, max: 100, color: Color(0xFF1E88E5)),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('الدرجات', style: GoogleFonts.tajawal(fontWeight: FontWeight.w700)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('أداء المواد', style: GoogleFonts.tajawal(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ..._grades.map((grade) => _GradeCard(grade: grade)),
          const SizedBox(height: 24),
          Card(
            elevation: 0,
            color: scheme.secondaryContainer,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.auto_awesome, color: scheme.onSecondaryContainer),
                      const SizedBox(width: 8),
                      Text('توصيات الذكاء الاصطناعي',
                          style: GoogleFonts.tajawal(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '• ركز على اللغة الإنجليزية، درجاتك أقل من المتوسط.\n• أداؤك ممتاز في الرياضيات والعلوم، استمر.\n• خصص 15 دقيقة يومياً للمراجعة.',
                    style: GoogleFonts.tajawal(height: 1.5, color: scheme.onSecondaryContainer),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradeCard extends StatelessWidget {
  const _GradeCard({required this.grade});
  final GradeRow grade;

  @override
  Widget build(BuildContext context) {
    final ratio = grade.percentage;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(grade.subject, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Spacer(),
                Text('${grade.score}/${grade.max}',
                    style: TextStyle(color: grade.color, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: ratio,
              minHeight: 8,
              backgroundColor: grade.color.withAlpha(51),
              color: grade.color,
            ),
          ],
        ),
      ),
    );
  }
}