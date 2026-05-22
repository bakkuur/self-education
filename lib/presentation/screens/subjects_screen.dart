import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart/domain/models/school_subject.dart';
import 'package:smart/presentation/screens/subject_units_screen.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final subjects = SchoolSubject.getMockSubjects();

    return Scaffold(
      backgroundColor: scheme.surfaceContainerLowest,
      appBar: AppBar(
        title: Text('المواد الدراسية', style: GoogleFonts.tajawal(fontWeight: FontWeight.w800)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.92,
          ),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return _SubjectCard(subject: subject);
          },
        ),
      ),
    );
  }
}

class _SubjectCard extends StatefulWidget {
  const _SubjectCard({required this.subject});
  final SchoolSubject subject;

  @override
  State<_SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<_SubjectCard> {
  bool _pressed = false;

  void _openUnits() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubjectUnitsScreen(
          subjectId: widget.subject.id,
          subjectName: widget.subject.title,
          subjectColor: widget.subject.color,
          units: widget.subject.units,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _openUnits,
        onHighlightChanged: (v) => setState(() => _pressed = v),
        borderRadius: BorderRadius.circular(20),
        child: AnimatedScale(
          scale: _pressed ? 0.97 : 1,
          duration: const Duration(milliseconds: 120),
          child: Card(
            elevation: _pressed ? 0 : 2,
            shadowColor: widget.subject.color.withAlpha(88),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [widget.subject.color.withAlpha(61), widget.subject.color.withAlpha(18)],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'subject_icon_${widget.subject.id}',
                      child: Material(
                        color: widget.subject.color.withAlpha(64),
                        shape: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Icon(widget.subject.icon, size: 40, color: widget.subject.color),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      widget.subject.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.tajawal(fontSize: 15, fontWeight: FontWeight.w800, color: scheme.onSurface),
                    ),
                    const SizedBox(height: 6),
                    Text('وحدات', style: GoogleFonts.tajawal(fontSize: 12, color: scheme.onSurfaceVariant)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}