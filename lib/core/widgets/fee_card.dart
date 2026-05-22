import 'package:flutter/material.dart';

class FeeCard extends StatelessWidget {
  const FeeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.attach_money),
        title: const Text('الرسوم الدراسية'),
        subtitle: const Text('الدفع: 5000 ريال'),
        trailing: const Chip(label: Text('مستحق')),
        onTap: () {},
      ),
    );
  }
}