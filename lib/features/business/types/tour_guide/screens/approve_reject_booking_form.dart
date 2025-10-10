import 'package:flutter/material.dart';

class ApproveRejectBookingForm extends StatelessWidget {
  const ApproveRejectBookingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Approve or Reject Booking', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {
                // Approve logic
                Navigator.pop(context);
              }, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text('Approve')),
              ElevatedButton(onPressed: () {
                // Reject logic
                Navigator.pop(context);
              }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text('Reject')),
            ],
          ),
        ],
      ),
    );
  }
}