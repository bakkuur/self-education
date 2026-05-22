import 'package:flutter/material.dart';

class SchoolMapScreen extends StatelessWidget {
  const SchoolMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('خريطة المدرسة')),
      body: const Center(
        child: Text('هذه الشاشة قيد التطوير', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}