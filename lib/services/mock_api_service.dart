import 'package:dio/dio.dart';

class MockApiService {
  final Dio _dio;
  
  MockApiService(this._dio) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Mock delay
          Future.delayed(const Duration(milliseconds: 500), () {
            handler.next(options);
          });
        },
        onResponse: (response, handler) {
          // Mock successful responses
          if (options.path.contains('/login')) {
            return handler.resolve(Response(
              requestOptions: options,
              data: {
                'token': 'mock_token_12345',
                'user': {
                  'id': 1,
                  'email': options.data['email'],
                  'username': 'mockuser',
                  'role': 'tourist',
                  'gps_consent': true,
                  'mfa_enabled': false,
                  'created_at': DateTime.now().toIso8601String(),
                  'updated_at': DateTime.now().toIso8601String(),
                },
              },
            ));
          }
          
          if (options.path.contains('/register')) {
            return handler.resolve(Response(
              requestOptions: options,
              data: {
                'token': 'mock_token_12345',
                'user': {
                  'id': 1,
                  'email': options.data['email'],
                  'username': options.data['username'],
                  'role': options.data['role'],
                  'gps_consent': options.data['gps_consent'],
                  'mfa_enabled': options.data['mfa_enabled'],
                  'created_at': DateTime.now().toIso8601String(),n m, 
                  'updated_at': DateTime.now().toIso8601String(),
                },
              },
            ));
          }
          
          if (options.path.contains('/user')) {
            return handler.resolve(Response(
              requestOptions: options,
              data: {
                'id': 1,
                'email': 'test@example.com',
                'username': 'mockuser',
                'role': 'tourist',
                'gps_consent': true,
                'mfa_enabled': false,
                'created_at': DateTime.now().toIso8601String(),
                'updated_at': DateTime.now().toIso8601String(),
              },
            ));
          }
          
          handler.next(response);
        },
        onError: (error, handler) {
          handler.next(error);
        },
      ),
    );
  }
}