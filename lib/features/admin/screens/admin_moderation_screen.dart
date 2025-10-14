import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminModerationScreen extends StatelessWidget {
  const AdminModerationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('attractions.duration'.tr())),
      body: DataTable(
        columns: [
          DataColumn(label: Text('tourist.search.mid'.tr())),
          DataColumn(label: Text('business.rental.room_type'.tr())),
          DataColumn(label: Text('tourist.categories.attractions'.tr())),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text('1'.tr())),
              DataCell(Text('business.profile.business_name'.tr())),
              DataCell(
                Row(
                  children: [
                    IconButton(icon: const Icon(Icons.check), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.close), onPressed: () {}),
                  ],
                ),
              ),
            ],
          ),
          // Add mock rows as needed
        ],
      ),
    );
  }
}
