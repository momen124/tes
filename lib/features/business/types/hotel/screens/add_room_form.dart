import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddRoomForm extends StatefulWidget {
  const AddRoomForm({super.key});

  @override
  State<AddRoomForm> createState() => _AddRoomFormState();
}

class _AddRoomFormState extends State<AddRoomForm> {
  final _formKey = GlobalKey<FormState>();
  double _price = 150.0;
  int _capacity = 2;
  bool _available = true;

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
              decoration: const InputDecoration(labelText: 'Room Name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            Text('Price per night: \$${ _price.toInt() }'),
            Slider(value: _price, min: 0, max: 500, onChanged: (val) => setState(() => _price = val)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Capacity'),
                IconButton(onPressed: () => setState(() => _capacity = (_capacity - 1).clamp(1, 10)), icon: const Icon(Icons.remove)),
                Text('$_capacity'),
                IconButton(onPressed: () => setState(() => _capacity = (_capacity + 1).clamp(1, 10)), icon: const Icon(Icons.add)),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Photo'),
            const DottedBorder(
              child: SizedBox(
                height: 100,
                child: Center(child: Text('Click to upload or drag and drop\nSVG, PNG, JPG (MAX. 800x400px)')),
              ),
            ),
            SwitchListTile(title: const Text('Availability'), value: _available, onChanged: (val) => setState(() => _available = val)),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                ElevatedButton(onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Add room
                    Navigator.pop(context);
                  }
                }, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), child: const Text('Add Room')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}