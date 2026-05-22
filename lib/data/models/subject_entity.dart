// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubjectEntity {
  final String id;
  final String name;
  final String? description;
  final String iconName;
  final int order;
  final String colorHex;

  SubjectEntity({
    required this.id,
    required this.name,
    this.description,
    required this.iconName,
    required this.order,
    required this.colorHex,
  });

  factory SubjectEntity.fromMap(Map<String, dynamic> data, {required String id}) {
    return SubjectEntity(
      id: id,
      name: data['name'] ?? '',
      description: data['description'],
      iconName: data['iconName'] ?? 'book_rounded',
      order: data['order'] ?? 0,
      colorHex: data['colorHex'] ?? '#3949AB',
    );
  }

  Color get color => Color(int.parse(colorHex.substring(1), radix: 16) + 0xFF000000);

  IconData get icon {
    switch (iconName) {
      case 'calculate_rounded':
        return Icons.calculate_rounded;
      case 'science_rounded':
        return Icons.science_rounded;
      case 'translate_rounded':
        return Icons.translate_rounded;
      case 'abc_rounded':
        return Icons.abc_rounded;
      case 'public_rounded':
        return Icons.public_rounded;
      case 'mosque_rounded':
        return Icons.mosque_rounded;
      default:
        return Icons.book_rounded;
    }
  }
}