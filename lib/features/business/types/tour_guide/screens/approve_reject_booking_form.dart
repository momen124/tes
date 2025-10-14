import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ApproveRejectBookingForm extends StatelessWidget {
  const ApproveRejectBookingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'common.ok'.tr(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Approve logic
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text('app.name'.tr()),
              ),
              ElevatedButton(
                onPressed: () {
                  // Reject logic
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('business.rental.vehicle_types.electric'.tr()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
