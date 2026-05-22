import 'package:flutter/material.dart';

class AttendanceSummaryCard extends StatelessWidget {
  const AttendanceSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('نسبة الحضور'),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha(26),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('95%', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const LinearProgressIndicator(value: 0.95, minHeight: 8, color: Colors.green),
          ],
        ),
      ),
    );
  }
}