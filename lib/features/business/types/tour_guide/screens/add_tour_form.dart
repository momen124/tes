import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AddTourForm extends StatefulWidget {
  const AddTourForm({super.key});

  @override
  State<AddTourForm> createState() => _AddTourFormState();
}

class _AddTourFormState extends State<AddTourForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
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
            ListTile(
              title: Text('Select Date'.tr()),
              subtitle: Text(_date.toString()),
              onTap: () async {
                final selected = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime.now(), lastDate: DateTime(2030));
                if (selected != null) setState(() => _date = selected);
              },
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
                }, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), child: Text('Add Tour'.tr())),
              ],
            ),
          ],
        ),
      ),
    );
  }
}