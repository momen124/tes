// lib/screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siwa/providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _role = 'tourist';
  bool _gpsConsent = false;
  bool _mfaEnabled = false;

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: _usernameController, decoration: const InputDecoration(labelText: 'Username')),
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            DropdownButton<String>(
              value: _role,
              items: const [
                DropdownMenuItem(value: 'tourist', child: Text('Tourist')),
                DropdownMenuItem(value: 'business', child: Text('Business')),
                DropdownMenuItem(value: 'admin', child: Text('Admin')),
              ],
              onChanged: (value) => setState(() => _role = value!),
            ),
            SwitchListTile(title: const Text('GPS Consent'), value: _gpsConsent, onChanged: (val) => setState(() => _gpsConsent = val)),
            SwitchListTile(title: const Text('MFA Enabled'), value: _mfaEnabled, onChanged: (val) => setState(() => _mfaEnabled = val)),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref.read(authProvider.notifier).register(
                    _emailController.text,
                    _usernameController.text,
                    _passwordController.text,
                    _role,
                    _gpsConsent,
                    _mfaEnabled,
                  );
                  if (context.mounted) {
                    context.go('/home');
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}