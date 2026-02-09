import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeData get themeData => _themeMode == ThemeMode.light ? _lightTheme : _darkTheme;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  static final _lightTheme = ThemeData(
    primaryColor: const Color(0xFF7CD0FF),
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF7CD0FF),
      secondary: const Color(0xFFE8FAFF),
      surface: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Color(0xFF0D0D0D)),
    ),
    // Add more styles as needed from your Colors.xaml
  );

  static final _darkTheme = ThemeData(
    primaryColor: const Color(0xFF7CD0FF),
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFF7CD0FF),
      secondary: const Color(0xFFE8FAFF),
      surface: Colors.black,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Color(0xFFC3C3C3)),
    ),
    // Mirror your dark styles
  );
}