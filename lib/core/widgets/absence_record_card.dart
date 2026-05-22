import 'package:flutter/material.dart';

class AbsenceRecordCard extends StatelessWidget {
  const AbsenceRecordCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.calendar_today),
        title: const Text('سجل الغياب'),
        subtitle: const Text('لم يتم تسجيل أي غياب بعد'),
        onTap: () {},
      ),
    );
  }
}