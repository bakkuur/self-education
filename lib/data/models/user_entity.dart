import 'package:smart/domain/models/user.dart';

class UserEntity {
  final String id;
  final String fullName;
  final String email;
  final String school;
  final String grade;
  final int age;
  final String gender;
  final DateTime createdAt;
  final double totalScore;
  final Map<String, int> subjectScores;

  UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.school,
    required this.grade,
    required this.age,
    required this.gender,
    required this.createdAt,
    this.totalScore = 0,
    this.subjectScores = const {},
  });

  Map<String, dynamic> toFirestore() {
    return {
      'fullName': fullName,
      'email': email,
      'school': school,
      'grade': grade,
      'age': age,
      'gender': gender,
      'createdAt': createdAt.toIso8601String(),
      'totalScore': totalScore,
      'subjectScores': subjectScores,
    };
  }

  factory UserEntity.fromFirestore(Map<String, dynamic> data, String id) {
    return UserEntity(
      id: id,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      school: data['school'] ?? '',
      grade: data['grade'] ?? 'الصف السابع',
      age: data['age'] ?? 0,
      gender: data['gender'] ?? 'ذكر',
      createdAt: DateTime.parse(data['createdAt'] ?? DateTime.now().toIso8601String()),
      totalScore: (data['totalScore'] ?? 0).toDouble(),
      subjectScores: Map<String, int>.from(data['subjectScores'] ?? {}),
    );
  }

  User toDomain() {
    return User(
      fullName: fullName,
      username: email.split('@').first,
      email: email,
      school: school,
      grade: grade,
      age: age,
      gender: gender,
      profileImagePath: null,
    );
  }

  factory UserEntity.fromDomain(User user, String id) {
    return UserEntity(
      id: id,
      fullName: user.fullName,
      email: user.email,
      school: user.school,
      grade: user.grade,
      age: user.age,
      gender: user.gender,
      createdAt: DateTime.now(),
    );
  }
}