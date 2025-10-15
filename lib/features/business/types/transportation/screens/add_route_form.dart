import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AddRouteForm extends StatefulWidget {
  const AddRouteForm({super.key});

  @override
  State<AddRouteForm> createState() => _AddRouteFormState();
}

class _AddRouteFormState extends State<AddRouteForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Route Name'.tr(), border: const OutlineInputBorder()),
              onChanged: (val) => _name = val,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'.tr(), border: const OutlineInputBorder()),
              maxLines: 3,
              onChanged: (val) => _description = val,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Cancel'.tr())),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                }, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), child: Text('Add Route'.tr())),
              ],
            ),
          ],
        ),
      ),
    );
  }
}