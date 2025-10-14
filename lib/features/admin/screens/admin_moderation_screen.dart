import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminModerationScreen extends StatelessWidget {
  const AdminModerationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Moderation Queue'.tr())),
      body: DataTable(
        columns:  [
          DataColumn(label: Text('ID'.tr())),
          DataColumn(label: Text('Type'.tr())),
          DataColumn(label: Text('Actions'.tr())),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('1'.tr())),
            DataCell(Text('Business'.tr())),
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