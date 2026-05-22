import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart/domain/models/user.dart';
import 'package:smart/presentation/screens/subjects_screen.dart';
import 'package:smart/presentation/screens/study_plan_screen.dart';
import 'package:smart/presentation/screens/grades_screen.dart';
import 'package:smart/presentation/screens/settings_screen.dart';
import 'package:smart/domain/usecases/get_user_profile_use_case.dart';
import 'package:smart/data/repositories/user_repository_impl.dart';
import 'package:smart/data/datasources/local/shared_prefs_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, this.onNavigateToPage});
  final ValueChanged<int>? onNavigateToPage;

  static const double _dailyProgress = 0.6;

  // تهيئة الـ UseCase
  Future<GetUserProfileUseCase> _getUserUseCase() async {
    final prefs = await SharedPreferences.getInstance();
    final helper = SharedPrefsHelper(prefs);
    final repository = UserRepositoryImpl(helper);
    return GetUserProfileUseCase(repository);
  }

  void _openTab(BuildContext context, int index) {
    if (onNavigateToPage != null) {
      onNavigateToPage!(index);
    } else {
      Widget screen;
      switch (index) {
        case 1:
          screen = const SubjectsScreen();
          break;
        case 2:
          screen = const StudyPlanScreen();
          break;
        case 3:
          screen = const GradesScreen();
          break;
        case 4:
          screen = const SettingsScreen();
          break;
        default:
          return;
      }
      Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              sliver: SliverToBoxAdapter(
                child: FutureBuilder<GetUserProfileUseCase>(
                  future: _getUserUseCase(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final useCase = snapshot.data!;
                      return StreamBuilder<User>(
                        stream: useCase.watch(),
                        builder: (context, userSnapshot) {
                          final user = userSnapshot.data ?? User.empty;
                          return _Header(
                            scheme: scheme,
                            user: user,
                            onSettings: () => _openTab(context, 4),
                          );
                        },
                      );
                    }
                    return _Header(
                      scheme: scheme,
                      user: User.empty,
                      onSettings: () => _openTab(context, 4),
                    );
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              sliver: SliverToBoxAdapter(
                child: _TodayPlanCard(
                  backgroundColor: scheme.primaryContainer,
                  foregroundColor: scheme.onPrimaryContainer,
                  progress: _dailyProgress,
                  onOpenPlan: () => _openTab(context, 2),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              sliver: SliverToBoxAdapter(
                child: _QuickActions(
                  onStartStudy: () => _openTab(context, 1),
                  onGrades: () => _openTab(context, 3),
                  onReview: () => _openTab(context, 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.scheme, required this.user, required this.onSettings});
  final ColorScheme scheme;
  final User user;
  final VoidCallback onSettings;

  String get _firstName {
    final full = user.fullName.trim();
    return full.isEmpty ? 'طالب' : full.split(RegExp(r'\s+')).first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: scheme.primaryContainer,
          child: Icon(Icons.person_rounded, size: 36, color: scheme.onPrimaryContainer),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('مرحباً بك يا $_firstName',
                  style: GoogleFonts.tajawal(fontSize: 22, fontWeight: FontWeight.bold, color: scheme.onSurface)),
              const SizedBox(height: 6),
              Text('الصف: ${user.grade}',
                  style: GoogleFonts.tajawal(fontSize: 15, color: scheme.onSurfaceVariant)),
            ],
          ),
        ),
        IconButton.filledTonal(onPressed: onSettings, icon: const Icon(Icons.settings_rounded)),
      ],
    );
  }
}

class _TodayPlanCard extends StatelessWidget {
  const _TodayPlanCard({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.progress,
    required this.onOpenPlan,
  });
  final Color backgroundColor, foregroundColor;
  final double progress;
  final VoidCallback onOpenPlan;

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        onTap: onOpenPlan,
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.event_note_rounded, color: foregroundColor, size: 26),
                const SizedBox(width: 10),
                Text('خطة اليوم',
                    style: GoogleFonts.tajawal(fontSize: 20, fontWeight: FontWeight.w800, color: foregroundColor))
              ]),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    height: 88,
                    width: 88,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 8,
                          backgroundColor: foregroundColor.withAlpha(51),
                          color: foregroundColor,
                        ),
                        Text('$percent%',
                            style: GoogleFonts.tajawal(fontSize: 20, fontWeight: FontWeight.bold, color: foregroundColor)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('تم الإنجاز',
                            style: GoogleFonts.tajawal(fontSize: 17, fontWeight: FontWeight.w700, color: foregroundColor)),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 10,
                            backgroundColor: foregroundColor.withAlpha(51),
                            color: foregroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({
    required this.onStartStudy,
    required this.onGrades,
    required this.onReview,
  });
  final VoidCallback onStartStudy, onGrades, onReview;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('اختصارات سريعة',
            style: GoogleFonts.tajawal(fontSize: 17, fontWeight: FontWeight.w700, color: scheme.onSurface)),
        const SizedBox(height: 12),
        Row(
          children: [
            _ActionCard(
                label: 'بدء الدراسة',
                icon: Icons.play_circle_filled_rounded,
                color: const Color(0xFF00897B),
                onTap: onStartStudy),
            const SizedBox(width: 12),
            _ActionCard(
                label: 'الدرجات',
                icon: Icons.bar_chart_rounded,
                color: const Color(0xFF5E35B1),
                onTap: onGrades),
            const SizedBox(width: 12),
            _ActionCard(
                label: 'المراجعة',
                icon: Icons.auto_stories_rounded,
                color: const Color(0xFFE65100),
                onTap: onReview),
          ],
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Expanded(
      child: FilledButton.tonal(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: color.withAlpha(56),
          foregroundColor: scheme.onSurface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(height: 6),
            Text(label, style: GoogleFonts.tajawal(fontSize: 12, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}