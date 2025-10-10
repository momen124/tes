import 'package:flutter/material.dart';

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
              decoration: const InputDecoration(labelText: 'Route Name', border: OutlineInputBorder()),
              onChanged: (val) => _name = val,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
              maxLines: 3,
              onChanged: (val) => _description = val,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                }, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), child: const Text('Add Route')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}