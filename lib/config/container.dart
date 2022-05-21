import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';

class AppContainer {
  static const defaultHeight = 80.0;
  static const Radius defaultRadius =
      Radius.circular(AppBorders.defaultBorderRadius);

  static const _bottomBorderRadius = BorderRadius.only(
    bottomLeft: defaultRadius,
    bottomRight: defaultRadius,
  );

  /// A BoxDecoration with a:
  /// - LightThemeData.primary color, if Ligth Theme;
  /// - Colors.transparent color, if Dark Theme.
  static final defaultDecoration = BoxDecoration(
    color: themeController.isDarkTheme
        ? Colors.transparent
        : LightThemeData.primary,
  );

  /// An extended version of the [AppContainer.defaultDecoration],
  /// with bottomLeft and bottomRight Border Radius.
  static final defaultDecorationWithBottomRadius =
      defaultDecoration.copyWith(borderRadius: _bottomBorderRadius);
}
