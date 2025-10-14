import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminLogsScreen extends StatelessWidget {
  const AdminLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('auth.login'.tr())),
      body: DataTable(
        columns: [
          DataColumn(label: Text('tourist.search.mid'.tr())),
          DataColumn(label: Text('business.rental.room_type'.tr())),
          DataColumn(label: Text('common.details'.tr())),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text('1'.tr())),
              DataCell(Text('common.edit'.tr())),
              DataCell(Text('common.details'.tr())),
            ],
          ), // Added closing bracket
          // Add mock rows
        ],
      ),
    );
  }
}
