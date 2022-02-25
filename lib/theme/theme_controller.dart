import 'package:flutter/material.dart';


class ThemeController with ChangeNotifier {

  static ThemeController? _instance;

  static ThemeController get instance {
    _instance??= ThemeController();
    return _instance!;
  }

  bool _isDarkTheme = false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  ThemeData get lightTheme {
    return ThemeData(
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
  }

  ThemeData get darkTheme {
    return ThemeData(
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
  }

}