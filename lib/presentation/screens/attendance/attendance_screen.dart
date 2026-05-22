import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الحضور والغياب')),
      body: const Center(
        child: Text('هذه الشاشة قيد التطوير', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}