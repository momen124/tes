// lib/features/business/types/store/screens/add_product_form.dart
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
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
              decoration: InputDecoration(labelText: 'Product Name'.tr(), border: const OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            Text('Price: ${_price.toInt()}'.tr()),
            Slider(value: _price, min: 0, max: 500, onChanged: (val) => setState(() => _price = val)),
            const SizedBox(height: 16),
            Text('Photo'.tr()),
             DottedBorder(
              child: SizedBox(
                height: 100,
                child: Center(child: Text('Upload Photo'.tr())),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'.tr(), border: const OutlineInputBorder()),
              maxLines: 3,
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
                }, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), child: Text('Add Product'.tr())),
              ],
            ),
          ],
        ),
      ),
    );
  }
}