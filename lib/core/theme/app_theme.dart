import 'package:flutter/material.dart';

class AppDimens {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;
}

ThemeData buildAppTheme() {
  final base = ColorScheme.fromSeed(
    seedColor: const Color(0xFF5B4B8A),
    brightness: Brightness.light,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: base,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: base.surface,
      foregroundColor: base.onSurface,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
