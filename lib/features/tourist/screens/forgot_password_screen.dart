import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // For offline queuing if needed
import '../../providers/offline_provider.dart';
import '../../../services/mock_api_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();

  Future<void> _sendResetLink() async {
    if (_formKey.currentState!.validate()) {
      final offlineProvider = Provider.of<OfflineProvider>(context, listen: false);
      try {
        await MockApiService().resetPassword(_emailOrPhoneController.text);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset link sent!')));
      } catch (e) {
        offlineProvider.queueAction('reset_password', {'email_or_phone': _emailOrPhoneController.text});
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Request queued offline.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'No worries, we\'ll send you reset instructions.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _emailOrPhoneController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your email or phone number',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    prefixIcon: Icon(Icons.mail),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email or phone';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _sendResetLink,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Send Reset Link', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 8),
              Center(
                child: TextButton(
                  onPressed: _sendResetLink,
                  child: const Text('Didn\'t receive the link? Resend'),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back to Login', style: TextStyle(color: Colors.orange)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}