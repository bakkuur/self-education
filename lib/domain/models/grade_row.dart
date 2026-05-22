import 'package:flutter/material.dart';

class GradeRow {
  final String subject;
  final int score;
  final int max;
  final Color color;

  const GradeRow({
    required this.subject,
    required this.score,
    required this.max,
    required this.color,
  });

  double get percentage => max > 0 ? score / max : 0.0;
}