// lib/features/business/types/restaurant/screens/add_item_form.dart
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AddItemForm extends StatefulWidget {
  const AddItemForm({super.key});

  @override
  State<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();
  double _price = 100.0;

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
              decoration: InputDecoration(labelText: 'Item Name'.tr(), border: const OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            Text('Price: ${_price.toInt()} EGP'.tr()),
            Slider(value: _price, min: 0, max: 500, onChanged: (val) => setState(() => _price = val)),
            const SizedBox(height: 16),
            Text('Photo'.tr()),
             DottedBorder(
              child: SizedBox(
                height: 100,
                child: Center(child: Text('Click to upload or drag and drop'.tr())),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'.tr(), border: const OutlineInputBorder()),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Cancel'.tr())),
                ElevatedButton(onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                }, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), child: Text('Add Item'.tr())),
              ],
            ),
          ],
        ),
      ),
    );
  }
}