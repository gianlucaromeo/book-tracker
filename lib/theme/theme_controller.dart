import 'package:book_tracker/config/general_settings.dart';
import 'package:book_tracker/config/palette.dart';
import 'package:flutter/material.dart';

final themeController = ThemeController.instance;

class ThemeController with ChangeNotifier {

  ThemeController._(); // Private constructor to make class Singleton
  static final ThemeController _instance = ThemeController._();
  static ThemeController get instance => _instance;

  bool _isDarkTheme = false;

  ThemeMode get currentThemeMode => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static final _fontFamily = GeneralSettings.textStyle.fontFamily;

  final _lightThemeData = ThemeData(
    fontFamily: _fontFamily,
    backgroundColor: Palette.backgroundLight,
    primaryColor: Palette.primaryLight,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Palette.primaryLight,
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(color: Palette.titleLight),
      subtitle1: TextStyle(color: Palette.subtitleLight),
    ),
  );

  final _darkThemeData = ThemeData(
    fontFamily: _fontFamily,
    backgroundColor: Colors.black,
    primaryColor: Colors.red,
    scaffoldBackgroundColor: Colors.blue,
    textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.white),
      headline2: TextStyle(color: Colors.white),
      bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white),
    ),
  );

  ThemeData get lightThemeData => _lightThemeData;
  ThemeData get darkThemeData => _darkThemeData;
  ThemeData get currentThemeData => _isDarkTheme ? darkThemeData : lightThemeData;

}