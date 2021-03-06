import 'package:book_tracker/config/general.dart';
import 'package:flutter/material.dart';

class DarkThemeData {
  static const Color secondary = Color.fromRGBO(22, 22, 24, 1.0);
  static Color primary = const Color.fromRGBO(12, 12, 12, 1.0);
  static Color onPrimary = Colors.white.withOpacity(0.5);
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
  static Color bottomNavBarBackground = secondary;
  static Color bottomNavBarUnselectedIcon = Colors.grey;
  static Color bottomNavBarSelectedIcon = Colors.white;

  /* SCAFFOLD */
  static Color scaffoldBackgroundColor = background;

  /* SEARCHED BOOK PAGE */
  static Color searchedBookPageBookTitle = Colors.white;
  static Color searchedBookPageBookAuthors = Colors.white.withOpacity(0.5);

  /* DEFAULT COLOR -- Should not be necessary */
  static final Color _defaultColor = primary;

  static get themeData => ThemeData(
        fontFamily: GeneralSettings.textStyle.fontFamily,
        colorScheme: ColorScheme(
          /* OBBLIGATORI */
          background: background, // SingleChildScrollView Background
          brightness: Brightness.dark,
          error: _defaultColor,
          onSurface: _defaultColor, // AppBar title|leading|actions,
          onPrimary: onPrimary, // ElevatedButton Text,
          onError: _defaultColor,
          onSecondary: _defaultColor,
          onBackground: _defaultColor,
          secondary: _defaultColor,
          surface: secondary, // AppBar background
          primary: primary, // ElevatedButton Background, OutlinedButton text
          /* OPZIONALI */
          shadow: shadow,
        ),
        /* ==== APP BAR THEME ==== */
        appBarTheme: AppBarTheme(
          backgroundColor: appBarBackground,
          toolbarHeight: 50.0,
          elevation: 0.0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: appBarText,
            fontSize: 19,
          ),
          actionsIconTheme: IconThemeData(
            color: appBarIcon,
            size: 30.0,
          ),
          iconTheme: IconThemeData(
            color: appBarIcon,
            size: 30.0,
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
            size: 30.0,
            color: bottomNavBarSelectedIcon,
          ),
          unselectedIconTheme: IconThemeData(
            size: 30.0,
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
