class Unit {
  final String id;
  final String subjectId;
  final String title;
  final String? description;
  final int unitNumber;
  final String? videoUrl;
  final int duration;
  final int order;
  final double progress;

  const Unit({
    required this.id,
    required this.subjectId,
    required this.title,
    this.description,
    required this.unitNumber,
    this.videoUrl,
    this.duration = 0,
    this.order = 0,
    this.progress = 0.0,
  });

  Unit copyWith({double? progress}) {
    return Unit(
      id: id,
      subjectId: subjectId,
      title: title,
      description: description,
      unitNumber: unitNumber,
      videoUrl: videoUrl,
      duration: duration,
      order: order,
      progress: progress ?? this.progress,
    );
  }

  // بيانات تجريبية للوحدات
  static List<Unit> getMockUnits(String subjectId) {
    final titles = [
      'مقدمة المادة',
      'الوحدة الأولى: الأساسيات',
      'الوحدة الثانية: المتوسط',
      'الوحدة الثالثة: المتقدم',
      'مراجعة شاملة',
      'الاختبار النهائي',
    ];

    return List.generate(6, (i) => Unit(
      id: '${subjectId}_unit_$i',
      subjectId: subjectId,
      title: titles[i],
      description: 'وصف الوحدة ${i + 1}',
      unitNumber: i + 1,
      order: i,
      progress: i == 0 ? 1.0 : (i == 1 ? 0.5 : 0.0),
    ));
  }
}