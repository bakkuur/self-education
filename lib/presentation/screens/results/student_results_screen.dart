import 'package:flutter/material.dart';

class StudentResultsScreen extends StatelessWidget {
  const StudentResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نتائج الطلاب')),
      body: const Center(
        child: Text('هذه الشاشة قيد التطوير', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}