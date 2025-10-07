// lib/providers/offline_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final offlineProvider = StateNotifierProvider<OfflineNotifier, bool>((ref) => OfflineNotifier());

class OfflineNotifier extends StateNotifier<bool> {
  OfflineNotifier() : super(false) {
    _listenToConnectivity();
  }

  void _listenToConnectivity() {
    Connectivity().onConnectivityChanged.listen((result) {
      state = result == ConnectivityResult.none;
    });
  }
}