import 'package:book_tracker/config/palette.dart';
import 'package:flutter/material.dart';

class AppBarUtil {

  static const _shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(60.0),
      bottomRight: Radius.circular(60.0),
    ),
  );

  static const _titleTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 27.0,
    letterSpacing: 1,
  );

  static const appBarTheme = AppBarTheme(
    toolbarHeight: 130.0,
    elevation: 0.0,
    centerTitle: true,
    shape: _shape,
    titleTextStyle: _titleTextStyle,
  );


}
