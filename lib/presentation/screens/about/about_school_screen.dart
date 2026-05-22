import 'package:flutter/material.dart';

class AboutSchoolScreen extends StatelessWidget {
  const AboutSchoolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عن المدرسة')),
      body: const Center(
        child: Text('هذه الشاشة قيد التطوير', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}