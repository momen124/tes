import 'package:flutter/material.dart';
import '../../../services/mock_api_service.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();

  Future<void> _simulatePayment() async {
    if (_formKey.currentState!.validate()) {
      try {
        await MockApiService().simulatePayment({
          'card_number': _cardNumberController.text,
          'expiry': _expiryController.text,
          'cvv': _cvvController.text,
          'name': _nameController.text,
        });
        Navigator.pushReplacementNamed(context, '/booking_confirmation');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment failed. Try again.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(labelText: 'Card Number', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) => value!.length != 16 ? 'Invalid card number' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryController,
                      decoration: const InputDecoration(labelText: 'Expiry (MM/YY)', border: OutlineInputBorder()),
                      keyboardType: TextInputType.datetime,
                      validator: (value) => value!.length != 5 ? 'Invalid expiry' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _cvvController,
                      decoration: const InputDecoration(labelText: 'CVV', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.length != 3 ? 'Invalid CVV' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Cardholder Name', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Enter name' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _simulatePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Pay Now', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}