import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart/domain/models/curriculum_unit.dart';
import 'package:smart/presentation/screens/unit_detail_screen.dart';

class SubjectUnitsScreen extends StatelessWidget {
  const SubjectUnitsScreen({
    super.key,
    required this.subjectId,
    required this.subjectName,
    required this.subjectColor,
    required this.units,
  });
  final String subjectId;
  final String subjectName;
  final Color subjectColor;
  final List<CurriculumUnit> units;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surfaceContainerLowest,
      appBar: AppBar(
        title: Text(subjectName, style: GoogleFonts.tajawal(fontWeight: FontWeight.bold)),
        backgroundColor: subjectColor.withAlpha(30),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: units.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final unit = units[index];
          final order = index + 1;
          final percent = (unit.progress * 100).round();

          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UnitDetailScreen(
                      unitId: unit.id,
                      unitTitle: unit.title,
                      subjectName: subjectName,
                      subjectColor: subjectColor,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: subjectColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(unit.icon, color: subjectColor, size: 26),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الوحدة $order',
                              style: GoogleFonts.tajawal(fontSize: 12, fontWeight: FontWeight.w600, color: subjectColor)),
                          Text(unit.title,
                              style: GoogleFonts.tajawal(fontSize: 16, fontWeight: FontWeight.w700, color: scheme.onSurface)),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: unit.progress.clamp(0.0, 1.0),
                                  minHeight: 8,
                                  backgroundColor: subjectColor.withAlpha(38),
                                  color: subjectColor,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text('$percent%',
                                  style: GoogleFonts.tajawal(fontSize: 13, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_left, color: scheme.outline),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}