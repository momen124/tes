import 'package:flutter/material.dart';

class AdminModerationScreen extends StatelessWidget {
  const AdminModerationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moderation Queue')),
      body: DataTable(
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Type')),
          DataColumn(label: Text('Actions')),
        ],
        rows: [
          DataRow(cells: [
            const DataCell(Text('1')),
            const DataCell(Text('Business')),
            DataCell(Row(children: [
              IconButton(icon: const Icon(Icons.check), onPressed: () {}),
              IconButton(icon: const Icon(Icons.close), onPressed: () {}),
            ])),
          ]),
          // Add mock rows as needed
        ],
      ),
    );
  }
}