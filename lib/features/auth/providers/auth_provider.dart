// lib/providers/auth_provider.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class User {
  final String email;
  final String? username;

  User({
    required this.email,
    this.username,
  });
}

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: 'http://localhost:3000/api')); // Replace with your actual API base URL
});

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  final dio = ref.watch(dioProvider);
  final storage = ref.watch(secureStorageProvider);
  return AuthNotifier(dio, storage);
});

class AuthNotifier extends StateNotifier<User?> {
  final Dio dio;
  final FlutterSecureStorage storage;

  AuthNotifier(this.dio, this.storage) : super(null) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    final token = await storage.read(key: 'auth_token');
    if (token != null) {
      try {
        dio.options.headers['Authorization'] = 'Bearer $token';
        final response = await dio.get('/user'); // Assume an endpoint to fetch user profile
        final data = response.data;
        state = User(
          email: data['email'],
          username: data['username'],
        );
      } catch (e) {
        await logout();
      }
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await dio.post('/login', data: {
        'email': email,
        'password': password,
      });
      final token = response.data['token'];
      await storage.write(key: 'auth_token', value: token);
      dio.options.headers['Authorization'] = 'Bearer $token';
      final userResponse = await dio.get('/user');
      final data = userResponse.data;
      state = User(
        email: data['email'],
        username: data['username'],
      );
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<void> register(
    String email,
    String username,
    String password,
    String role,
    bool gpsConsent,
    bool mfaEnabled,
  ) async {
    try {
      final response = await dio.post('/register', data: {
        'email': email,
        'username': username,
        'password': password,
        'role': role,
        'gps_consent': gpsConsent,
        'mfa_enabled': mfaEnabled,
      });
      final token = response.data['token'];
      await storage.write(key: 'auth_token', value: token);
      dio.options.headers['Authorization'] = 'Bearer $token';
      state = User(
        email: email,
        username: username,
      );
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    state = null;
    await storage.delete(key: 'auth_token');
    dio.options.headers.remove('Authorization');
  }
}