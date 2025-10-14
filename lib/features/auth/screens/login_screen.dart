import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siwa/features/auth/providers/auth_provider.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/utils/validators.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(authProvider.notifier).login(
        _emailController.text.trim(),
        _passwordController.text,
      );
      
      if (mounted) {
        setState(() => _isLoading = false);
        
        final user = ref.read(authProvider);
        if (user != null) {
          final role = (user as dynamic).role;
          switch (role) {
            case 'tourist':
              context.go('/tourist_home');
              break;
            case 'business':
              context.go('/business_dashboard');
              break;
            case 'admin':
              context.go('/admin_dashboard');
              break;
            default:
              context.go('/tourist_home');
          }
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppTheme.errorRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.park, color: AppTheme.primaryOrange, size: 36),
                        const SizedBox(width: 12),
                        Text('Siwa Oasis'.tr(), style: AppTheme.headlineLarge),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Welcome Back',
                      style: AppTheme.bodyLarge.copyWith(color: AppTheme.gray),
                    ),
                    const SizedBox(height: 40),
                    
                    // Form
                    Container(
                      decoration: AppTheme.cardDecoration,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email'.tr(),
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.validateEmail,
                          ),
                          const SizedBox(height: 16),
                          
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password'.tr(),
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                            obscureText: true,
                            validator: Validators.validatePassword,
                          ),
                          const SizedBox(height: 24),
                          
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleLogin,
                              child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: AppTheme.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text('Login'.tr(), style: AppTheme.buttonText),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    TextButton(
                      onPressed: () => context.go('/register'),
                      child: Text(
                        'Don\'t have an account? Register',
                        style: AppTheme.bodyMedium.copyWith(color: AppTheme.gray),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    const Icon(Icons.landscape, color: AppTheme.gray, size: 48),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/debug_navigator'),
        backgroundColor: AppTheme.primaryOrange,
        child: const Icon(Icons.developer_mode),
      ),
    );
  }
}