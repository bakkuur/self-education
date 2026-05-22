import 'package:cloud_firestore/cloud_firestore.dart';

class UnitEntity {
  final String id;
  final String subjectId;
  final String title;
  final String? description;
  final int unitNumber;
  final String? videoUrl;
  final int duration;
  final int order;

  UnitEntity({
    required this.id,
    required this.subjectId,
    required this.title,
    this.description,
    required this.unitNumber,
    this.videoUrl,
    this.duration = 0,
    this.order = 0,
  });

  factory UnitEntity.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UnitEntity(
      id: doc.id,
      subjectId: data['subjectId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'],
      unitNumber: data['unitNumber'] ?? 0,
      videoUrl: data['videoUrl'],
      duration: data['duration'] ?? 0,
      order: data['order'] ?? 0,
    );
  }
}