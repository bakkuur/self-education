import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart/presentation/theme/theme_notifier.dart';
import 'package:smart/domain/models/user.dart';
import 'package:smart/domain/usecases/get_user_profile_use_case.dart';
import 'package:smart/domain/usecases/clear_user_data_use_case.dart';
import 'package:smart/data/repositories/user_repository_impl.dart';
import 'package:smart/data/datasources/local/shared_prefs_helper.dart';
import 'package:smart/presentation/screens/auth/register_screen.dart';
import 'package:smart/presentation/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  late Future<GetUserProfileUseCase> _userUseCase;
  late Future<ClearUserDataUseCase> _clearUseCase;

  @override
  void initState() {
    super.initState();
    _initUseCases();
  }

  Future<void> _initUseCases() async {
    final prefs = await SharedPreferences.getInstance();
    final helper = SharedPrefsHelper(prefs);
    final repository = UserRepositoryImpl(helper);
    _userUseCase = Future.value(GetUserProfileUseCase(repository));
    _clearUseCase = Future.value(ClearUserDataUseCase(repository));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: scheme.surfaceContainerLowest,
        appBar: AppBar(title: Text('الإعدادات', style: GoogleFonts.tajawal(fontWeight: FontWeight.w700))),
        body: FutureBuilder(
          future: _userUseCase,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final userUseCase = snapshot.data!;
            return StreamBuilder<User>(
              stream: userUseCase.watch(),
              builder: (context, userSnapshot) {
                final user = userSnapshot.data ?? User.empty;
                return ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  children: [
                    _buildProfileHeader(context, scheme, user),
                    const SizedBox(height: 28),
                    _buildCategoryLabel('الحساب', scheme),
                    const SizedBox(height: 10),
                    _SettingsCard(
                      child: Column(
                        children: [
                          _ChevronTile(
                              icon: Icons.edit,
                              label: 'تعديل الملف الشخصي',
                              onTap: () => _navigateToEditProfile(context)),
                          _divider(),
                          _ChevronTile(
                              icon: Icons.shield_outlined,
                              label: 'الحماية',
                              onTap: () => _showInfoDialog(context, Icons.shield_outlined, 'الحماية',
                                  'نلتزم بحماية حسابك وبياناتك الشخصية.')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildCategoryLabel('تفضيلات التطبيق', scheme),
                    const SizedBox(height: 10),
                    _SettingsCard(
                      child: Column(
                        children: [
                          ValueListenableBuilder<ThemeMode>(
                            valueListenable: appThemeModeNotifier,
                            builder: (context, mode, _) {
                              final isDark = mode == ThemeMode.dark;
                              return _SwitchTile(
                                icon: Icons.dark_mode_outlined,
                                label: 'الوضع الليلي',
                                value: isDark,
                                onChanged: (v) {
                                  appThemeModeNotifier.value = v ? ThemeMode.dark : ThemeMode.light;
                                },
                              );
                            },
                          ),
                          _divider(),
                          _SwitchTile(
                            icon: Icons.notifications_outlined,
                            label: 'الإشعارات',
                            value: _notificationsEnabled,
                            onChanged: (v) => setState(() => _notificationsEnabled = v),
                          ),
                          _divider(),
                          _ChevronTile(
                              icon: Icons.language_rounded,
                              label: 'تغيير اللغة',
                              onTap: () => _showLanguageSheet(context)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildCategoryLabel('الدعم', scheme),
                    const SizedBox(height: 10),
                    _SettingsCard(
                      child: Column(
                        children: [
                          _ChevronTile(
                              icon: Icons.help_outline,
                              label: 'مركز المساعدة',
                              onTap: () => _showInfoDialog(context, Icons.help_outline, 'مركز المساعدة',
                                  'للتواصل: support@smartschool.com')),
                          _divider(),
                          _ChevronTile(
                              icon: Icons.description_outlined,
                              label: 'شروط الخدمة',
                              onTap: () => _showInfoDialog(context, Icons.description_outlined, 'شروط الخدمة',
                                  'باستخدامك للتطبيق، توافق على الشروط.')),
                          _divider(),
                          _ChevronTile(
                              icon: Icons.group_outlined,
                              label: 'فريق العمل',
                              onTap: () => _showInfoDialog(context, Icons.group_outlined, 'فريق العمل',
                                  'طور التطبيق طالب علوم حاسوب - المستوى الرابع')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    FutureBuilder(
                      future: _clearUseCase,
                      builder: (context, clearSnapshot) {
                        if (!clearSnapshot.hasData) {
                          return const SizedBox.shrink();
                        }
                        final clearUseCase = clearSnapshot.data!;
                        return FilledButton.icon(
                          onPressed: () => _showLogoutDialog(context, clearUseCase),
                          icon: const Icon(Icons.logout_rounded),
                          label: Text('تسجيل الخروج',
                              style: GoogleFonts.tajawal(fontSize: 17, fontWeight: FontWeight.w700)),
                          style: FilledButton.styleFrom(
                              minimumSize: const Size.fromHeight(54),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Center(
                        child: Text('المدرسة الذكية — الإصدار 1.0.0',
                            style: GoogleFonts.tajawal(fontSize: 12, color: scheme.onSurfaceVariant))),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, ColorScheme scheme, User user) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 52,
              backgroundColor: scheme.primaryContainer,
              backgroundImage: user.profileImagePath != null ? FileImage(File(user.profileImagePath!)) : null,
              child: user.profileImagePath == null
                  ? Icon(Icons.person_rounded, size: 56, color: scheme.onPrimaryContainer)
                  : null,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Material(
                color: scheme.primary,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () => _navigateToEditProfile(context),
                  child: const SizedBox(width: 36, height: 36, child: Icon(Icons.edit, size: 18, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(user.fullName,
            style: GoogleFonts.tajawal(fontSize: 26, fontWeight: FontWeight.w800, color: scheme.onSurface)),
        const SizedBox(height: 6),
        Text(user.username, style: GoogleFonts.tajawal(fontSize: 16, color: scheme.primary)),
        const SizedBox(height: 4),
        Text(user.email, style: GoogleFonts.tajawal(fontSize: 14, color: scheme.onSurfaceVariant)),
        const SizedBox(height: 4),
        Text('طالب علوم حاسوب', style: GoogleFonts.tajawal(fontSize: 15, color: scheme.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildCategoryLabel(String text, ColorScheme scheme) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: Text(text,
            style: GoogleFonts.tajawal(fontSize: 12.5, fontWeight: FontWeight.w800, color: scheme.onSurfaceVariant)),
      ),
    );
  }

  Widget _divider() => Divider(height: 1, thickness: 1, indent: 16, endIndent: 56, color: Colors.grey.shade300);

  void _navigateToEditProfile(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen(isEditMode: true)));
  }

  void _showInfoDialog(BuildContext context, IconData icon, String title, String body) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        icon: Icon(icon, size: 28),
        title: Text(title),
        content: Text(body),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إغلاق'))],
      ),
    );
  }

  void _showLanguageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(title: const Text('العربية'), onTap: () => Navigator.pop(ctx)),
              ListTile(title: const Text('English'), onTap: () => Navigator.pop(ctx)),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, ClearUserDataUseCase clearUseCase) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تسجيل الخروج'),
        content: const Text('هل تريد تسجيل الخروج؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () async {
              await clearUseCase.execute();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                (route) => false,
              );
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Card(
      elevation: 1, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), child: child);
}

class _ChevronTile extends StatelessWidget {
  const _ChevronTile({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) =>
      ListTile(leading: Icon(icon), title: Text(label), trailing: const Icon(Icons.chevron_left), onTap: onTap);
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({required this.icon, required this.label, required this.value, required this.onChanged});
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) =>
      ListTile(leading: Icon(icon), title: Text(label), trailing: Switch(value: value, onChanged: onChanged));
}