import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';

class LoginSignUpFormSizes {
  static const buttonHeight = 50.0;
  static const buttonBorderRadius = 10.0;
  static const buttonIconSize = 25.0;
  static get border => OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(AppBorders.defaultBorderRadius),
        ),
        borderSide: BorderSide(
          color: themeController.isDarkTheme
              ? DarkThemeData.shadow
              : Colors.black.withOpacity(0.1),
        ),
      );
  static get floatingLabelStyle => TextStyle(
        color: themeController.isDarkTheme
            ? DarkThemeData.onPrimary
            : Colors.black,
      );
  static get cursorColor => LightThemeData.primary;
}
