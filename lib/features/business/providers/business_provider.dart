import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusinessState {
  final String language;
  final bool gpsEnabled;

  BusinessState({this.language = 'en', this.gpsEnabled = true});

  BusinessState copyWith({String? language, bool? gpsEnabled}) {
    return BusinessState(
      language: language ?? this.language,
      gpsEnabled: gpsEnabled ?? this.gpsEnabled,
    );
  }
}

class BusinessNotifier extends StateNotifier<BusinessState> {
  BusinessNotifier() : super(BusinessState());

  void setLanguage(String lang) {
    state = state.copyWith(language: lang);
  }

  void toggleGps(bool enabled) {
    state = state.copyWith(gpsEnabled: enabled);
  }

  void logout() {
    // Implement logout logic, e.g., clear auth
  }
}

final businessProvider = StateNotifierProvider<BusinessNotifier, BusinessState>(
  (ref) => BusinessNotifier(),
);
