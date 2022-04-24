import 'package:book_tracker/config/palette.dart';
import 'package:flutter/material.dart';

class LightThemeData {
  static get themeData => ThemeData(
        colorScheme: ColorScheme(
          /* OBBLIGATORI */
          background: Colors.yellow,
          error: Colors.red,
          onSurface: Colors.white, // AppBar title|leading|actions,
          onPrimary: Palette.lightestGrayLight, // ElevatedButton Text,
          onError: Colors.purple,
          onSecondary: Colors.orange,
          onBackground: Colors.amber,
          secondary: Colors.blue,
          surface: Palette.darkestLight, // AppBar background
          primary: Palette
              .primaryLight, // ElevatedButton Background, OutlinedButton text
          /* OPZIONALI */
          shadow: Colors.grey.withOpacity(0.1),
          /* BRIGHTNESS */
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        /* ==== APP BAR THEME ==== */
        appBarTheme: const AppBarTheme(
          backgroundColor: Palette.lightestGrayLight,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Palette.darkestLight,
          ),
          actionsIconTheme: IconThemeData(
            color: Palette.darkestLight,
          ),
          iconTheme: IconThemeData(
            color: Palette.darkestLight,
          ),
        ),
        /* ==== SCAFFOLD THEME ==== */
        scaffoldBackgroundColor: Palette.lightestGrayLight,
        /* ==== CHIP THEME ==== */
        chipTheme: const ChipThemeData(
          backgroundColor: Palette.lightestGrayLight,
          selectedColor: Palette.grayLight,
          elevation: 1.0,
        ),
      );
}
