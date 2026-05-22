class User {
  final String fullName;
  final String username;
  final String email;
  final String school;
  final String grade;
  final int age;
  final String gender;
  final String? profileImagePath;

  const User({
    required this.fullName,
    required this.username,
    required this.email,
    required this.school,
    required this.grade,
    required this.age,
    required this.gender,
    this.profileImagePath,
  });

  static const User empty = User(
    fullName: '',
    username: '',
    email: '',
    school: '',
    grade: 'الصف السابع',
    age: 0,
    gender: 'ذكر',
    profileImagePath: null,
  );

  User copyWith({
    String? fullName,
    String? username,
    String? email,
    String? school,
    String? grade,
    int? age,
    String? gender,
    String? profileImagePath,
  }) {
    return User(
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      email: email ?? this.email,
      school: school ?? this.school,
      grade: grade ?? this.grade,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      profileImagePath: profileImagePath ?? this.profileImagePath,
    );
  }

  String get shortName => fullName.split(' ').first;
  String get displayGrade => grade;
}