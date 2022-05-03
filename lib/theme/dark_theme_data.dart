import 'package:book_tracker/config/general.dart';
import 'package:flutter/material.dart';

class DarkThemeData {
  static Color surface = const Color.fromRGBO(0, 0, 0, 1.0);
  static Color primary = const Color.fromRGBO(12, 12, 12, 1.0);
  static Color onPrimary = Colors.grey.withOpacity(0.4);
  static Color background = primary;
  static Color shadow = Colors.grey.withOpacity(0.2);

  /* CHIP */
  static Color selectedChipBackground = Colors.white;
  static Color selectedChipText = Colors.black;
  static Color unslectedChipBackground = Colors.grey.withOpacity(0.5);
  static Color unselectedChipText = Colors.white;

  /* APP BAR */
  static Color appBarBackground = primary;
  static Color appBarIcon = Colors.white;
  static Color appBarText = Colors.white;

  /* BOTTOM NAVIGATION BAR */
  static Color bottomNavBarBackground = const Color.fromRGBO(24, 24, 24, 1.0);
  static Color bottomNavBarUnselectedIcon = Colors.grey;
  static Color bottomNavBarSelectedIcon = Colors.white;

  /* SCAFFOLD */
  static Color scaffoldBackgroundColor = background;

  /* SEARCHED BOOK PAGE */
  static Color searchedBookPageBookTitle = Colors.white;
  static Color searchedBookPageBookAuthors = Colors.white.withOpacity(0.5);

  static get themeData => ThemeData(
        fontFamily: GeneralSettings.textStyle.fontFamily,
        colorScheme: ColorScheme(
          /* OBBLIGATORI */
          background: background, // SingleChildScrollView Background
          brightness: Brightness.dark,
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
          shadow: shadow,
        ),
        /* ==== APP BAR THEME ==== */
        appBarTheme: AppBarTheme(
          backgroundColor: appBarBackground,
          toolbarHeight: 80.0,
          elevation: 0.0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: appBarText,
            fontSize: 19,
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
        scaffoldBackgroundColor: scaffoldBackgroundColor,
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
