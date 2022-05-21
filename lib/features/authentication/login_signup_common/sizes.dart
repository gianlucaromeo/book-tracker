import 'package:book_tracker/config/borders.dart';
import 'package:flutter/material.dart';

class LoginSignUpFormSizes {
  static const buttonHeight = 50.0;
  static const buttonBorderRadius = 10.0;
  static const buttonIconSize = 25.0;
  static final border = OutlineInputBorder(
    borderRadius: const BorderRadius.all(
      Radius.circular(AppBorders.defaultBorderRadius),
    ),
    borderSide: BorderSide(
      color: Colors.black.withOpacity(0.1),
    ),
  );
}
