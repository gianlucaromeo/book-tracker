import 'package:book_tracker/config/general.dart';
import 'package:book_tracker/config/palette.dart';
import 'package:book_tracker/theme/app_bar_theme.dart';
import 'package:flutter/material.dart';

final themeController = ThemeController.instance;

class ThemeController with ChangeNotifier {
  ThemeController._(); // Private constructor to make class Singleton
  static final ThemeController _instance = ThemeController._();
  static ThemeController get instance => _instance;

  bool _isDarkTheme = false;

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
    appBarTheme: AppBarUtil.appBarTheme,
    useMaterial3: true,
  );

  final _darkThemeData = ThemeData(
    fontFamily: _fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarUtil.appBarTheme,
    useMaterial3: true,
  );
  /*
  final _lightThemeData = ThemeData(
    fontFamily: _fontFamily,
    primaryColor: Palette.primaryLight,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      toolbarHeight: 80.0,
      elevation: 0.0,
    ),
    backgroundColor: Palette.backgroundLight,
    // Custom TextField
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    // Custom Button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(50.0),
        textStyle: const TextStyle(fontSize: 20.0),
        backgroundColor: Colors.blueAccent,
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
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
   */

  /*
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

   */

  ThemeData get lightThemeData => _lightThemeData;
  ThemeData get darkThemeData => _darkThemeData;
  ThemeData get currentThemeData =>
      _isDarkTheme ? darkThemeData : lightThemeData;
}
