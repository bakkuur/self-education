import 'package:flutter/material.dart';
import 'curriculum_unit.dart';

class SchoolSubject {
  final String id;
  final String title;
  final Color color;
  final IconData icon;
  final List<CurriculumUnit> units;

  const SchoolSubject({
    required this.id,
    required this.title,
    required this.color,
    required this.icon,
    required this.units,
  });

  // بيانات تجريبية للمواد
  static List<SchoolSubject> getMockSubjects() {
    return [
      SchoolSubject(
        id: 'math',
        title: 'الرياضيات',
        color: const Color(0xFF3949AB),
        icon: Icons.calculate_rounded,
        units: CurriculumUnit.getMockUnits('math'),
      ),
      SchoolSubject(
        id: 'science',
        title: 'العلوم',
        color: const Color(0xFF00897B),
        icon: Icons.science_rounded,
        units: CurriculumUnit.getMockUnits('science'),
      ),
      SchoolSubject(
        id: 'arabic',
        title: 'اللغة العربية',
        color: const Color(0xFFC62828),
        icon: Icons.translate_rounded,
        units: CurriculumUnit.getMockUnits('arabic'),
      ),
      SchoolSubject(
        id: 'english',
        title: 'الإنجليزية',
        color: const Color(0xFF1565C0),
        icon: Icons.abc_rounded,
        units: CurriculumUnit.getMockUnits('english'),
      ),
      SchoolSubject(
        id: 'social',
        title: 'الاجتماعيات',
        color: const Color(0xFF6D4C41),
        icon: Icons.public_rounded,
        units: CurriculumUnit.getMockUnits('social'),
      ),
      SchoolSubject(
        id: 'islamic',
        title: 'التربية الإسلامية',
        color: const Color(0xFF6A1B9A),
        icon: Icons.mosque_rounded,
        units: CurriculumUnit.getMockUnits('islamic'),
      ),
    ];
  }
}