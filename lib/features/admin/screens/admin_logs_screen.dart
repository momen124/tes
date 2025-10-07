import 'package:flutter/material.dart';

class AdminLogsScreen extends StatelessWidget {
  const AdminLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logs')),
      body: DataTable(
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Type')),
          DataColumn(label: Text('Details')),
        ],
        rows: const [
          DataRow(cells: [
            DataCell(Text('1')),
            DataCell(Text('Audit')),
            DataCell(Text('Mock details')),
          ]), // Added closing bracket
          // Add mock rows
        ],
      ),
    );
  }
}