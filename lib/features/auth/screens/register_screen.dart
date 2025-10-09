import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_widget/styled_widget.dart'; // Ensure this import is correct
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/auth/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Add this import for Riverpod

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mfaController = TextEditingController();
  final bool _gpsConsent = false;
  bool _isLoading = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) _controller.reverse();
      });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _mfaController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_emailController.text.isEmpty || !_isValidEmail(_emailController.text) || _passwordController.text.length < 6) {
      _showErrorModal('Please enter a valid email and password (6+ characters).');
      return;
    }

    setState(() => _isLoading = true);
    _controller.forward();

    try {
      await ref.read(authProvider.notifier).register(
        _emailController.text,
        _usernameController.text,
        _passwordController.text,
        'tourist', // Hardcoded role for now; consider a dropdown later
        _gpsConsent,
        _mfaController.text.isNotEmpty, // Convert to bool for mfaEnabled
      );
      if (mounted) {
        setState(() => _isLoading = false);
        context.go('/tourist_home');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showErrorModal('Registration failed: ${e.toString()}');
      }
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _showErrorModal(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error').textStyle(const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        content: Text(message).textStyle(AppTheme.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK').textColor(AppTheme.primaryOrange),
          ),
        ],
      ).borderRadius(all: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              _buildHeaderSection(),
              
              // Form Section
              _buildFormSection(),
              
              // Footer Section
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
        const SizedBox(height: 40),
        // Logo and App Name
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.park, color: AppTheme.primaryOrange, size: 36),
            const SizedBox(width: 12),
            const Text('Siwa Oasis').textStyle(AppTheme.headlineLarge),
          ],
        ),
        
        const SizedBox(height: 8),
        
        // Welcome Text
        const Text('Welcome Back')
            .textStyle(AppTheme.bodyLarge.copyWith(color: AppTheme.gray))
            .padding(bottom: 40),
      ],
    );
  }

  Widget _buildFormSection() {
    return Container(
      decoration: AppTheme.cardDecoration,
      child: Column(
        children: [
          // Email Field
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ).padding(bottom: 16),
          
          // Username Field
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ).padding(bottom: 16),
          
          // Divider
          const Divider(height: 32, thickness: 1, color: AppTheme.lightGray),
          
          // Password Field
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ).padding(bottom: 16),
          
          // GPS Toggle
          // Container(
          //   decoration: BoxDecoration(
          //     color: AppTheme.lightGray,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: SwitchListTile(
          //     title: const Text('Enable GPS').textStyle(AppTheme.bodyMedium),
          //     value: _gpsConsent,
          //     onChanged: (val) => setState(() => _gpsConsent = val),
          //     activeColor: AppTheme.primaryOrange,
          //   ),
          // ).padding(bottom: 16),
          
          // MFA Field
          TextField(
            controller: _mfaController,
            decoration: const InputDecoration(labelText: 'MFA Code (Optional)'),
          ).padding(bottom: 24),
          
          // Register Button
          _buildRegisterButton(),
        ],
      ).padding(all: 24),
    );
  }

  Widget _buildRegisterButton() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _isLoading ? 1.0 : _animation.value,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleRegister,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: AppTheme.white, strokeWidth: 2),
                    )
                  : const Text('Register').textStyle(AppTheme.buttonText),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooterSection() {
    return Column(
      children: [
        const SizedBox(height: 24),
        
        // Sign In Link
        TextButton(
          onPressed: () => context.go('/login'),
          child: const Text('Already have an account? Sign in')
              .textStyle(AppTheme.bodyMedium.copyWith(color: AppTheme.gray)),
        ),
        
        const SizedBox(height: 40),
        
        // Decorative Icon
        const Icon(Icons.landscape, color: AppTheme.gray, size: 48),
      ],
    );
  }
}