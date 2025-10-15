import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siwa/features/auth/providers/auth_provider.dart';
import 'package:siwa/app/theme.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Wait for splash duration
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final auth = ref.read(authProvider);
    if (auth != null) {
      // Navigate based on role; support different user models by reading common fields via dynamic
      final String role =
          ((auth as dynamic).role ??
                  (auth as dynamic).type ??
                  (auth as dynamic).userType ??
                  (auth as dynamic).roles ??
                  'unknown')
              .toString();
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
          context.go('/login');
      }
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.park, size: 100, color: AppTheme.primaryOrange),
              const SizedBox(height: 24),
              Text(
                'Siwa Oasis',
                style: AppTheme.headlineLarge.copyWith(fontSize: 36),
              ),
              const SizedBox(height: 8),
              Text(
                'Discover the Desert Paradise',
                style: AppTheme.bodyLarge.copyWith(color: AppTheme.gray),
              ),
              const SizedBox(height: 40),
              const CircularProgressIndicator(color: AppTheme.primaryOrange),
            ],
          ),
        ),
      ),
    );
  }
}
