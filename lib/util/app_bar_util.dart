import 'package:book_tracker/config/palette.dart';
import 'package:flutter/material.dart';

class AppBarUtil {
  static const _shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(60.0),
      bottomRight: Radius.circular(60.0),
    ),
  );

  static AppBar buildAppBar(
  {required double toolbarHeight, required double elevation, required bool centerTitle, required String text}) {
    return AppBar(
      toolbarHeight: toolbarHeight,
      elevation: elevation,
      shape: _shape,
      backgroundColor: Palette.primaryLight,
      centerTitle: centerTitle,
      title: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 27.0,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
