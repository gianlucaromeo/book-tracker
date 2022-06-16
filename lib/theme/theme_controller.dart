import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:flutter/material.dart';

final themeController = ThemeController.instance;

class ThemeController with ChangeNotifier {
  ThemeController._(); // Singleton
  static final ThemeController _instance = ThemeController._();
  static ThemeController get instance => _instance;

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  ThemeMode get currentThemeMode =>
      _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  ThemeData get lightThemeData => LightThemeData.themeData;
  ThemeData get darkThemeData => DarkThemeData.themeData;
  ThemeData get currentThemeData =>
      _isDarkTheme ? darkThemeData : lightThemeData;
}
