import 'package:book_tracker/config/general.dart';
import 'package:book_tracker/config/palette.dart';
import 'package:flutter/material.dart';

final themeController = ThemeController.instance;

class ThemeController with ChangeNotifier {
  ThemeController._(); // Singleton
  static final ThemeController _instance = ThemeController._();
  static ThemeController get instance => _instance;

  bool _isDarkTheme = true;

  ThemeMode get currentThemeMode =>
      _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static final _fontFamily = GeneralSettings.textStyle.fontFamily;

  final _lightThemeData = ThemeData(
    fontFamily: _fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Palette.tertiaryLight,
      brightness: Brightness.light,
    ),
    //appBarTheme: AppBarUtil.introAppBarTheme,
    useMaterial3: true,
  );

  final _darkThemeData = ThemeData(
    fontFamily: _fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue[900]!,
      brightness: Brightness.dark,
    ),
    //appBarTheme: AppBarUtil.introAppBarTheme, // TODO
    useMaterial3: true,
  );

  ThemeData get lightThemeData => _lightThemeData;
  ThemeData get darkThemeData => _darkThemeData;
  ThemeData get currentThemeData =>
      _isDarkTheme ? darkThemeData : lightThemeData;
}
