import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnitDetailScreen extends StatelessWidget {
  const UnitDetailScreen({
    super.key,
    required this.unitId,
    required this.unitTitle,
    required this.subjectName,
    required this.subjectColor,
  });
  final String unitId;
  final String unitTitle;
  final String subjectName;
  final Color subjectColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(unitTitle, style: GoogleFonts.tajawal(fontWeight: FontWeight.w700))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: subjectColor.withAlpha(30),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: subjectColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(Icons.menu_book_rounded, color: subjectColor, size: 32),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(subjectName,
                              style: GoogleFonts.tajawal(fontSize: 13, fontWeight: FontWeight.w600, color: subjectColor)),
                          Text(unitTitle,
                              style: GoogleFonts.tajawal(fontSize: 18, fontWeight: FontWeight.w800, color: scheme.onSurface)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('محتوى الوحدة', style: GoogleFonts.tajawal(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('سيتم عرض محتوى الوحدة (فيديو، اختبارات، مواد) هنا لاحقاً.'),
            const SizedBox(height: 16),
            // زر البدء (تجريبي)
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('سيتم إضافة محتوى الوحدة قريباً')),
                );
              },
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('بدء الدراسة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: subjectColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}