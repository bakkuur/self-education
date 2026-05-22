import 'package:flutter/material.dart';

class TopStudentsScreen extends StatelessWidget {
  const TopStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الطلاب المتفوقين')),
      body: const Center(
        child: Text('هذه الشاشة قيد التطوير', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}