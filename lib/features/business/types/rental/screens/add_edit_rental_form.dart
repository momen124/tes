import 'package:flutter/material.dart';

class AddEditRentalForm extends StatefulWidget {
  const AddEditRentalForm({super.key});

  @override
  State<AddEditRentalForm> createState() => _AddEditRentalFormState();
}

class _AddEditRentalFormState extends State<AddEditRentalForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  double _price = 50.0;
  int _capacity = 1;
  bool _available = true;
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
              decoration: const InputDecoration(labelText: 'Rental Name', border: OutlineInputBorder()),
              onChanged: (val) => _name = val,
            ),
            const SizedBox(height: 16),
            Text('Price: \$${ _price.toInt() }'),
            Slider(value: _price, min: 0, max: 200, onChanged: (val) => setState(() => _price = val)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Capacity'),
                IconButton(onPressed: () => setState(() => _capacity--), icon: const Icon(Icons.remove)),
                Text('$_capacity'),
                IconButton(onPressed: () => setState(() => _capacity++), icon: const Icon(Icons.add)),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Photo'),
            Container(
              height: 100,
              decoration: BoxDecoration(border: Border.all(style: BorderStyle.dashed)),
              child: const Center(child: Text('Click to upload or drag and drop\nSVG, PNG, JPG (MAX. 800x400px)')),
            ),
            SwitchListTile(title: const Text('Available'), value: _available, onChanged: (val) => setState(() => _available = val)),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
              maxLines: 3,
              onChanged: (val) => _description = val,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                ElevatedButton(onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save via API
                    Navigator.pop(context);
                  }
                }, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), child: const Text('Save')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}