import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';

class AppContainer {
  /// Default height for Containers
  static const defaultHeight = 80.0;

  /// Default Radius value
  static const Radius _defaultRadius =
      Radius.circular(AppBorders.defaultBorderRadius);

  /// BorderRadius with only bottomLeft and bottomRight properties set to defaultRadius
  static const _bottomBorderRadius = BorderRadius.only(
    bottomLeft: _defaultRadius,
    bottomRight: _defaultRadius,
  );

  /// A BoxDecoration with a:
  /// - LightThemeData.primary color, if Ligth Theme;
  /// - Colors.transparent color, if Dark Theme.
  static final defaultDecoration = BoxDecoration(
    color: themeController.isDarkTheme
        ? DarkThemeData.secondary
        : LightThemeData.primary,
  );

  /// An extended version of the [AppContainer.defaultDecoration],
  /// with bottomLeft and bottomRight Border Radius.
  static final defaultDecorationWithBottomRadius =
      defaultDecoration.copyWith(borderRadius: _bottomBorderRadius);
}
