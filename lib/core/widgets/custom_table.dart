import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  const CustomTable({super.key, required this.headers, required this.rows});
  final List<String> headers;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(children: headers.map((h) => Padding(padding: const EdgeInsets.all(8), child: Text(h))).toList()),
        ...rows.map((row) => TableRow(children: row.map((c) => Padding(padding: const EdgeInsets.all(8), child: Text(c))).toList())),
      ],
    );
  }
}