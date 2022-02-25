import 'package:flutter/material.dart';

final themeController = ThemeController.instance;

class ThemeController with ChangeNotifier {

  ThemeController._privateConstructor();
  static final ThemeController _instance = ThemeController._privateConstructor();
  static ThemeController get instance => _instance;

  bool _isDarkTheme = false;

  ThemeMode get currentThemeMode => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  final _lightThemeData = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: Colors.lightBlueAccent,
    scaffoldBackgroundColor: Colors.orangeAccent,
    textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.black),
      headline2: TextStyle(color: Colors.black),
      bodyText1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.black),
    ),
  );

  final _darkThemeData = ThemeData(
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