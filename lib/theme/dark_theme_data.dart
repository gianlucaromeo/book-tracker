import 'package:book_tracker/config/general.dart';
import 'package:flutter/material.dart';

class DarkThemeData {
  static Color surface = Color.fromRGBO(0, 0, 0, 1.0);
  static Color primary = Color.fromRGBO(12, 12, 12, 1.0);
  static Color onPrimary = Colors.grey.withOpacity(0.4);
  static Color background = primary;

  static Color selectedChipBackground = Colors.white;
  static Color selectedChipText = Colors.black;
  static Color unslectedChipBackground = Colors.grey.withOpacity(0.5);
  static Color unselectedChipText = Colors.white;

  static Color appBarIcon = Colors.white;
  static Color appBarText = Colors.white;

  static Color bottomNavBarBackground = Color.fromRGBO(24, 24, 24, 1.0);
  static Color bottomNavBarUnselectedIcon = Colors.grey;
  static Color bottomNavBarSelectedIcon = Colors.white;

  static Color searchedBookPageBookTitle = Colors.white;
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
          brightness: Brightness.dark,
          /* OPZIONALI */
          shadow: Colors.grey.withOpacity(0.2),

          /* BRIGHTNESS */
        ),
        // useMaterial3: true,
        /* ==== APP BAR THEME ==== */
        appBarTheme: AppBarTheme(
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
          type: BottomNavigationBarType
              .fixed, // Otherwise cannot edit backgroundColor
          backgroundColor: bottomNavBarBackground,
          selectedIconTheme: IconThemeData(
            size: 40.0,
            color: bottomNavBarSelectedIcon,
          ),
          unselectedIconTheme: IconThemeData(
            size: 40.0,
            color: bottomNavBarUnselectedIcon,
          ),
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        /* ==== TAB BAR ==== */
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: onPrimary,
          labelStyle: TextStyle(
            color: primary,
            fontSize: 18,
          ),
          unselectedLabelStyle: TextStyle(
            color: Colors.grey.withOpacity(0.3),
            fontSize: 14,
          ),
        ),
      );
}
