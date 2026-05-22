import 'package:flutter/material.dart';

class CurriculumUnit {
  final String id;
  final String title;
  final IconData icon;
  final double progress;

  const CurriculumUnit({
    required this.id,
    required this.title,
    required this.icon,
    required this.progress,
  });

  // بيانات تجريبية للوحدات
  static List<CurriculumUnit> getMockUnits(String subjectId) {
    const titles = [
      'مقدمة المادة',
      'الوحدة الأولى',
      'الوحدة الثانية',
      'الوحدة الثالثة',
      'مراجعة نصف العام',
      'الاختبارات النهائية',
    ];
    const icons = [
      Icons.auto_stories_rounded,
      Icons.menu_book_rounded,
      Icons.play_circle_outline_rounded,
      Icons.menu_book_rounded,
      Icons.fact_check_rounded,
      Icons.quiz_rounded,
    ];

    // تقدم عشوائي تجريبي
    double getProgress(int index) {
      final n = (subjectId.hashCode * 19 + index * 31 + 7) % 92;
      return (n / 100).clamp(0.08, 0.98);
    }

    return List.generate(6, (i) => CurriculumUnit(
      id: '${subjectId}_unit_$i',
      title: titles[i],
      icon: icons[i],
      progress: getProgress(i),
    ));
  }
}