import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart/domain/models/user.dart';

class SharedPrefsHelper {
  static const String _kFullName = 'profile_full_name';
  static const String _kUsername = 'profile_username';
  static const String _kEmail = 'profile_email';
  static const String _kSchool = 'profile_school';
  static const String _kGrade = 'profile_grade';
  static const String _kAge = 'profile_age';
  static const String _kGender = 'profile_gender';
  static const String _kProfileImagePath = 'profile_image_path';
  static const String _kIsLoggedIn = 'is_logged_in';

  final SharedPreferences _prefs;

  SharedPrefsHelper(this._prefs);

  User getUser() {
    final isLoggedIn = _prefs.getBool(_kIsLoggedIn) ?? false;
    if (!isLoggedIn) return User.empty;

    return User(
      fullName: _prefs.getString(_kFullName) ?? '',
      username: _prefs.getString(_kUsername) ?? '',
      email: _prefs.getString(_kEmail) ?? '',
      school: _prefs.getString(_kSchool) ?? '',
      grade: _prefs.getString(_kGrade) ?? User.empty.grade,
      age: _prefs.getInt(_kAge) ?? 0,
      gender: _prefs.getString(_kGender) ?? User.empty.gender,
      profileImagePath: _prefs.getString(_kProfileImagePath),
    );
  }

  Future<void> saveUser(User user) async {
    await _prefs.setString(_kFullName, user.fullName);
    await _prefs.setString(_kUsername, user.username);
    await _prefs.setString(_kEmail, user.email);
    await _prefs.setString(_kSchool, user.school);
    await _prefs.setString(_kGrade, user.grade);
    await _prefs.setInt(_kAge, user.age);
    await _prefs.setString(_kGender, user.gender);
    if (user.profileImagePath != null) {
      await _prefs.setString(_kProfileImagePath, user.profileImagePath!);
    } else {
      await _prefs.remove(_kProfileImagePath);
    }
    await _prefs.setBool(_kIsLoggedIn, true);
  }

  Future<void> clearUser() async {
    await _prefs.clear();
  }

  Stream<User> watchUser() async* {
    // بسيط: في كل مرة نعيد getUser
    // يمكن تحسينها باستخدام ValueNotifier
    yield getUser();
  }
}