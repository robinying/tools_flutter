import 'dart:ui' show Locale;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persisted app locale override.
///
/// - `null` → follow system locale (Flutter resolves against [supportedLocales])
/// - explicit [Locale] → forced language
class LocaleController extends StateNotifier<Locale?> {
  LocaleController() : super(null) {
    _load();
  }

  static const prefKey = 'app_locale_code';

  /// Codes that map 1:1 to ARB locales (and menu items).
  static const supportedCodes = [
    'en',
    'zh',
    'fr',
    'de',
    'it',
    'es',
    'pt',
  ];

  static const supported = [
    Locale('en'),
    Locale('zh'),
    Locale('fr'),
    Locale('de'),
    Locale('it'),
    Locale('es'),
    Locale('pt'),
  ];

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(prefKey);
    if (code == null || code.isEmpty || code == 'system') {
      state = null;
      return;
    }
    if (!supportedCodes.contains(code)) {
      state = null;
      return;
    }
    state = Locale(code);
  }

  /// [code]: `system` | `en` | `zh` | `fr` | `de` | `it` | `es` | `pt`
  Future<void> setLocaleCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    if (code == 'system' || code.isEmpty) {
      await prefs.setString(prefKey, 'system');
      state = null;
      return;
    }
    if (!supportedCodes.contains(code)) return;
    await prefs.setString(prefKey, code);
    state = Locale(code);
  }

  String get currentCode {
    final l = state;
    if (l == null) return 'system';
    return l.languageCode;
  }
}

final localeControllerProvider =
    StateNotifierProvider<LocaleController, Locale?>((ref) {
  return LocaleController();
});
