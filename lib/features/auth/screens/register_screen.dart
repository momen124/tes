import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/auth/providers/auth_provider.dart';
import 'package:siwa/utils/validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  final String userType;
  
  const RegisterScreen({super.key, this.userType = 'tourist'});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _mfaController = TextEditingController();
  bool _gpsConsent = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _mfaController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(authProvider.notifier).register(
        _emailController.text.trim(),
        _usernameController.text.trim(),
        _passwordController.text,
        _phoneController.text.trim(),
        widget.userType == 'tourist',
        _gpsConsent,
      );
      
      if (mounted) {
        setState(() => _isLoading = false);
        
        final user = ref.read(authProvider);
        if (user != null) {
          switch (widget.userType) {
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
            content: Text('Registration failed: ${e.toString()}'.tr()),
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
                    const SizedBox(height: 40),
                    
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
                      'Create Account',
                      style: AppTheme.bodyLarge.copyWith(color: AppTheme.gray),
                    ),
                    const SizedBox(height: 40),
                    
                    // Form
                    Container(
                      decoration: AppTheme.cardDecoration,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          // Email
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
                          
                          // Username
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Username'.tr(),
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                            validator: (v) => Validators.validateRequired(v, 'Username'),
                          ),
                          const SizedBox(height: 16),
                          
                          // Phone
                          TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              labelText: 'Phone'.tr(),
                              hintText: '+20 123 456 7890'.tr(),
                              prefixIcon: Icon(Icons.phone_outlined),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: Validators.validatePhone,
                          ),
                          const SizedBox(height: 16),
                          
                          // Password
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password'.tr(),
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                            obscureText: true,
                            validator: Validators.validatePassword,
                          ),
                          const SizedBox(height: 16),
                          
                          // GPS Consent
                          Container(
                            decoration: BoxDecoration(
                              color: AppTheme.lightBlueGray,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SwitchListTile(
                              title: Text('Enable GPS'.tr(), style: AppTheme.bodyMedium),
                              subtitle: Text(
                                'Required for location features',
                                style: AppTheme.bodySmall,
                              ),
                              value: _gpsConsent,
                              onChanged: (val) => setState(() => _gpsConsent = val),
                              activeThumbColor: AppTheme.primaryOrange,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // MFA (Optional)
                          TextFormField(
                            controller: _mfaController,
                            decoration: InputDecoration(
                              labelText: 'MFA Code (Optional)'.tr(),
                              prefixIcon: Icon(Icons.security_outlined),
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // Register Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleRegister,
                              child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: AppTheme.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text('Register'.tr(), style: AppTheme.buttonText),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Login Link
                    TextButton(
                      onPressed: () => context.go('/login'),
                      child: Text(
                        'Already have an account? Sign in',
                        style: AppTheme.bodyMedium.copyWith(color: AppTheme.gray),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}