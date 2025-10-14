// lib/screens/admin_dashboard_screen.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('Admin Dashboard'.tr())),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: BarChart(BarChartData()),
          ),
        ],
      ),
    );
  }
}