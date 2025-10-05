// lib/screens/business_dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BusinessDashboardScreen extends StatelessWidget {
  const BusinessDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Business Dashboard')),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: PieChart(PieChartData()),
          ),
          Expanded(
            child: ListView(
              children: [
                Card(child: ListTile(title: Text('Listing 1'))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}