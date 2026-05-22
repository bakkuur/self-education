import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart/domain/models/user.dart';
import 'package:smart/domain/usecases/save_user_profile_use_case.dart';
import 'package:smart/domain/usecases/get_user_profile_use_case.dart';
import 'package:smart/data/repositories/user_repository_impl.dart';
import 'package:smart/data/datasources/local/shared_prefs_helper.dart';
import 'package:smart/data/datasources/local/image_picker_service.dart';
import 'package:smart/presentation/screens/main_navigation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, this.isEditMode = false});
  final bool isEditMode;

  static Route<void> route({bool isEditMode = false}) {
    return MaterialPageRoute(
      builder: (context) => RegisterScreen(isEditMode: isEditMode),
    );
  }

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _schoolController = TextEditingController();
  final _ageController = TextEditingController();

  String _selectedGrade = 'الصف السابع';
  String _selectedGender = 'ذكر';
  String? _profileImagePath;
  bool _isLoading = false;

  final List<String> _grades = ['الصف السابع', 'الصف الثامن', 'الصف التاسع'];
  final List<String> _genders = ['ذكر', 'أنثى'];
  final ImagePickerService _imagePicker = ImagePickerService();

  late Future<SaveUserProfileUseCase> _saveUseCase;
  // ignore: unused_field
  late Future<GetUserProfileUseCase> _getUseCase;

  @override
  void initState() {
    super.initState();
    _initUseCases();
  }

  Future<void> _initUseCases() async {
    final prefs = await SharedPreferences.getInstance();
    final helper = SharedPrefsHelper(prefs);
    final repository = UserRepositoryImpl(helper);
    _saveUseCase = Future.value(SaveUserProfileUseCase(repository));
    _getUseCase = Future.value(GetUserProfileUseCase(repository));
    if (widget.isEditMode) {
      final user = repository.getCurrentUser();
      _fullNameController.text = user.fullName;
      _usernameController.text = user.username;
      _emailController.text = user.email;
      _schoolController.text = user.school;
      _ageController.text = user.age > 0 ? user.age.toString() : '';
      _selectedGrade = _grades.contains(user.grade) ? user.grade : _grades.first;
      _selectedGender = _genders.contains(user.gender) ? user.gender : _genders.first;
      _profileImagePath = user.profileImagePath;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _schoolController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('اختر مصدر الصورة'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, ImageSource.gallery),
            child: const Text('المعرض'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, ImageSource.camera),
            child: const Text('الكاميرا'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, null),
            child: const Text('إلغاء'),
          ),
        ],
      ),
    );
    if (source == null) return;
    String? path;
    if (source == ImageSource.gallery) {
      path = await _imagePicker.pickImageFromGallery();
    } else {
      path = await _imagePicker.pickImageFromCamera();
    }
    if (path != null) {
      setState(() => _profileImagePath = path);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final age = int.tryParse(_ageController.text.trim());
    if (age == null || age < 5 || age > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال عمر صحيح (5-100)')),
      );
      return;
    }

    final fullName = _fullNameController.text.trim();
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final school = _schoolController.text.trim();

    if (fullName.isEmpty || username.isEmpty || email.isEmpty || school.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى تعبئة جميع الحقول (الاسم، اسم المستخدم، البريد، المدرسة)')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final newUser = User(
      fullName: fullName,
      username: username,
      email: email,
      school: school,
      grade: _selectedGrade,
      age: age,
      gender: _selectedGender,
      profileImagePath: _profileImagePath,
    );

    final saveUseCase = await _saveUseCase;
    await saveUseCase.execute(newUser);

    if (!mounted) return;

    if (widget.isEditMode) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تحديث البيانات بنجاح')),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: widget.isEditMode
          ? AppBar(title: Text('تعديل الملف الشخصي', style: GoogleFonts.tajawal()))
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (!widget.isEditMode) ...[
                  Icon(Icons.school_rounded, size: 72, color: scheme.primary),
                  const SizedBox(height: 16),
                  Text('تسجيل بيانات جديدة',
                      style: GoogleFonts.tajawal(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 32),
                ],
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: scheme.primaryContainer,
                    backgroundImage: _profileImagePath != null ? FileImage(File(_profileImagePath!)) : null,
                    child: _profileImagePath == null
                        ? Icon(Icons.camera_alt, size: 40, color: scheme.onPrimaryContainer)
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Text('اضغط لإضافة صورة',
                    style: GoogleFonts.tajawal(fontSize: 12, color: scheme.primary)),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _fullNameController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      labelText: 'الاسم الرباعي', prefixIcon: Icon(Icons.person, color: scheme.primary)),
                  validator: (v) => v!.trim().isEmpty ? 'الرجاء إدخال الاسم' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _usernameController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      labelText: 'اسم المستخدم', prefixIcon: Icon(Icons.account_circle, color: scheme.primary)),
                  validator: (v) => v!.trim().isEmpty ? 'الرجاء إدخال اسم المستخدم' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'البريد الإلكتروني', prefixIcon: Icon(Icons.email, color: scheme.primary)),
                  validator: (v) => v!.trim().isEmpty ? 'الرجاء إدخال البريد' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedGrade,
                  decoration: InputDecoration(
                      labelText: 'الصف الدراسي', prefixIcon: Icon(Icons.class_, color: scheme.primary)),
                  items: _grades.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                  onChanged: (v) => setState(() => _selectedGrade = v!),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _schoolController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      labelText: 'المدرسة', prefixIcon: Icon(Icons.school, color: scheme.primary)),
                  validator: (v) => v!.trim().isEmpty ? 'الرجاء إدخال المدرسة' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      labelText: 'العمر', prefixIcon: Icon(Icons.calendar_today, color: scheme.primary)),
                  validator: (v) {
                    final age = int.tryParse(v?.trim() ?? '');
                    if (age == null || age < 5 || age > 100) return 'عمر غير صحيح';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: InputDecoration(
                      labelText: 'الجنس', prefixIcon: Icon(Icons.person_outline, color: scheme.primary)),
                  items: _genders.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                  onChanged: (v) => setState(() => _selectedGender = v!),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Text(widget.isEditMode ? 'تحديث البيانات' : 'حفظ والانتقال للرئيسية'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}