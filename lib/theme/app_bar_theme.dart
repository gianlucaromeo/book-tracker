import 'package:flutter/material.dart';

class AppBarUtil {
  static const double _radius = 0.0; // 50.0;
  static get introAppBarTheme => AppBarTheme(
        //color: Colors.transparent,
        toolbarHeight: 100.0,
        elevation: 0.0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(_radius),
            bottomRight: Radius.circular(_radius),
          ),
        ),
        iconTheme: IconThemeData(
          size: 31.0,
          color: Colors.grey[350]!,
        ),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 27.0,
          letterSpacing: 1,
        ),
      );

  static get userAppBarTheme => const AppBarTheme(
        toolbarHeight: 80.0,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          fontSize: 23,
          letterSpacing: 1,
        ),
        centerTitle: true,
      );
}
