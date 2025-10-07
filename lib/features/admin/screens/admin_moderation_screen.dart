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
            DataCell(Text('1')),
            DataCell(Text('Business')),
            DataCell(Row(children: [
              IconButton(icon: Icon(Icons.check), onPressed: () {}),
              IconButton(icon: Icon(Icons.close), onPressed: () {}),
            ])),
          ]),
          // Add mock rows as needed
        ],
      ),
    );
  }
}