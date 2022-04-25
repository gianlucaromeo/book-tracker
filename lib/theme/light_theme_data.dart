import 'package:book_tracker/config/general.dart';
import 'package:flutter/material.dart';

class LightThemeData {
  // MAIN
  static const Color surface = Color.fromRGBO(46, 53, 81, 1.0);
  static const Color primary = Color.fromRGBO(80, 122, 240, 1.0);
  static const Color onPrimary = Color.fromRGBO(243, 240, 247, 1.0);
  // OTHER
  static const Color background = Colors.white;
  static Color selectedChipBackground = primary;
  static Color unslectedChipBackground = Colors.grey.withOpacity(0.1);
  static const Color selectedChipText = Colors.white;
  static const Color unselectedChipText = Colors.black;

  static const Color appBarIcon = Colors.black;
  static const Color appBarText = Colors.black;
  //static const Color bottomNavBarBackground = onPrimary;
  static Color bottomNavBarUnselectedIcon = surface.withOpacity(0.3);
  static const Color searchedBookPageBookTitle = Colors.white;
  static Color searchedBookPageBookAuthors = Colors.white.withOpacity(0.5);

  static get themeData => ThemeData(
        fontFamily: GeneralSettings.textStyle.fontFamily,
        colorScheme: ColorScheme(
          /* OBBLIGATORI */
          background: background, // SingleChildScrollView Background
          error: Colors.red,
          onSurface: Colors.white, // AppBar title|leading|actions,
          onPrimary: onPrimary, // ElevatedButton Text,
          onError: Colors.purple,
          onSecondary: Colors.orange,
          onBackground: Colors.amber,
          secondary: Colors.blue,
          surface: surface, // AppBar background
          primary: primary, // ElevatedButton Background, OutlinedButton text
          /* OPZIONALI */
          shadow: Colors.grey.withOpacity(0.1),
          /* BRIGHTNESS */
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        /* ==== APP BAR THEME ==== */
        appBarTheme: const AppBarTheme(
          backgroundColor: background,
          toolbarHeight: 80.0,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: appBarText,
          ),
          actionsIconTheme: IconThemeData(
            color: appBarIcon,
            size: 50.0,
          ),
          iconTheme: IconThemeData(
            color: appBarIcon,
            size: 50.0,
          ),
        ),
        /* ==== SCAFFOLD THEME ==== */
        scaffoldBackgroundColor: background,
        /* ==== CHIP THEME ==== */
        chipTheme: ChipThemeData(
          backgroundColor: unslectedChipBackground,
          selectedColor: selectedChipBackground,
          elevation: 0.0,
        ),
        /* ==== BOTTOM NAVIGATION BAR THEME ==== */
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0.0,
          type: BottomNavigationBarType.shifting,
          selectedIconTheme: const IconThemeData(
            size: 40.0,
            color: primary,
          ),
          unselectedIconTheme: IconThemeData(
            size: 40.0,
            color: bottomNavBarUnselectedIcon,
          ),
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        /* ==== TAB BAR ==== */
        tabBarTheme: const TabBarTheme(
          labelColor: primary,
          unselectedLabelColor: surface,
          labelStyle: TextStyle(color: primary),
        ),
      );
}
