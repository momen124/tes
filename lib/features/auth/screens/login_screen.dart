import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:siwa/features/auth/providers/auth_provider.dart';
import 'package:siwa/app/theme.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              _buildHeaderSection(),
              
              // Login Form
              _buildLoginForm(),
              
              // Footer
              _buildFooterSection(),
            ],
          ).padding(all: 24),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      children: [
        const SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.park, color: AppTheme.primaryOrange, size: 36),
            const SizedBox(width: 12),
            Text('Siwa Oasis').textStyle(AppTheme.headlineLarge),
          ],
        ),
        const SizedBox(height: 8),
        Text('Welcome Back')
            .textStyle(AppTheme.bodyLarge.copyWith(color: AppTheme.gray))
            .padding(bottom: 40),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Container(
      decoration: AppTheme.cardDecoration,
      child: Column(
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ).padding(bottom: 16),
          
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ).padding(bottom: 24),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                try {
                  await ref.read(authProvider.notifier).login(_emailController.text, _passwordController.text);
                  if (context.mounted) {
                    context.go('/tourist_home');
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                        backgroundColor: Colors.red,
                      )
                    );
                  }
                }
              },
              child: const Text('Login').textStyle(AppTheme.buttonText),
            ),
          ),
        ],
      ).padding(all: 24),
    );
  }

  Widget _buildFooterSection() {
    return Column(
      children: [
        const SizedBox(height: 24),
        TextButton(
          onPressed: () => context.go('/register'),
          child: const Text('Don\'t have an account? Register')
              .textStyle(AppTheme.bodyMedium.copyWith(color: AppTheme.gray)),
        ),
        const SizedBox(height: 40),
        const Icon(Icons.landscape, color: AppTheme.gray, size: 48),
      ],
    );
  }
}