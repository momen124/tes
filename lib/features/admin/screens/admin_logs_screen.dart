import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminLogsScreen extends StatelessWidget {
  const AdminLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Logs'.tr())),
      body: DataTable(
        columns:  [
          DataColumn(label: Text('ID'.tr())),
          DataColumn(label: Text('Type'.tr())),
          DataColumn(label: Text('Details'.tr())),
        ],
        rows:  [
          DataRow(cells: [
            DataCell(Text('1'.tr())),
            DataCell(Text('Audit'.tr())),
            DataCell(Text('Mock details'.tr())),
          ]), // Added closing bracket
          // Add mock rows
        ],
      ),
    );
  }
}