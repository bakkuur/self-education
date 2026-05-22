import 'package:intl/intl.dart';

String getFirstName(String fullName) {
  final parts = fullName.trim().split(RegExp(r'\s+'));
  return parts.isNotEmpty ? parts.first : 'طالب';
}

String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd', 'ar').format(date);
}

String formatPercentage(double value) {
  return '${(value * 100).round()}%';
}