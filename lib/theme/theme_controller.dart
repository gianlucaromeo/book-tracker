import 'package:book_tracker/config/general.dart';
import 'package:book_tracker/config/palette.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:flutter/material.dart';

final themeController = ThemeController.instance;

class ThemeController with ChangeNotifier {
  ThemeController._(); // Singleton
  static final ThemeController _instance = ThemeController._();
  static ThemeController get instance => _instance;

  bool _isDarkTheme = true;

  bool get isDarkTheme => _isDarkTheme;

  ThemeMode get currentThemeMode =>
      _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  ThemeData get lightThemeData => LightThemeData.themeData; // _lightThemeData;
  ThemeData get darkThemeData => DarkThemeData.themeData; //_darkThemeData;
  ThemeData get currentThemeData =>
      _isDarkTheme ? darkThemeData : lightThemeData;
}
