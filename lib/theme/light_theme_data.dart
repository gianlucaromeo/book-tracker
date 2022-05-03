import 'package:book_tracker/config/general.dart';
import 'package:flutter/material.dart';

class LightThemeData {
  static const Color surface = Color.fromRGBO(46, 53, 81, 1.0);
  static const Color primary = Color.fromRGBO(80, 122, 240, 1.0);
  static const Color onPrimary = Color.fromRGBO(243, 240, 247, 1.0);
  static const Color background = Colors.white;
  static Color shadow = Colors.grey.withOpacity(0.4);

  /* CHIP */
  static Color selectedChipBackground = primary;
  static const Color selectedChipText = Colors.white;
  static Color unslectedChipBackground = Colors.grey.withOpacity(0.1);
  static const Color unselectedChipText = Colors.black;

  /* APP BAR */
  static Color appBarBackground = background;
  static const Color appBarIcon = Colors.black;
  static const Color appBarText = Colors.black;

  /* BOTTOM NAVIGATION BAR */
  //static Color bottomNavBarBackground = const Color.fromRGBO(24, 24, 24, 1.0);
  static Color bottomNavBarUnselectedIcon = surface.withOpacity(0.3);
  static Color bottomNavBarSelectedIcon = primary;

  /* SCAFFOLD */
  static const Color scaffoldBackgroundColor = background;

  /* SEARCHED BOOK PAGE */
  static const Color searchedBookPageBookTitle = Colors.white;
  static Color searchedBookPageBookAuthors = Colors.white.withOpacity(0.5);

  static get themeData => ThemeData(
        fontFamily: GeneralSettings.textStyle.fontFamily,
        colorScheme: ColorScheme(
          /* OBBLIGATORI */
          background: background, // SingleChildScrollView Background
          brightness: Brightness.light,
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
          titleTextStyle: const TextStyle(
            color: appBarText,
            fontSize: 19,
          ),
          actionsIconTheme: const IconThemeData(
            color: appBarIcon,
            size: 50.0,
          ),
          iconTheme: const IconThemeData(
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
          type: BottomNavigationBarType.fixed,
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
          labelColor: primary,
          unselectedLabelColor: surface,
          labelStyle: const TextStyle(color: primary, fontSize: 18),
          unselectedLabelStyle: TextStyle(
            color: Colors.grey.withOpacity(0.3),
            fontSize: 14,
          ),
        ),
      );
}
