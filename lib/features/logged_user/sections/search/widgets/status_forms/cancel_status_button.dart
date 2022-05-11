import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';

class CancelStatusButton extends StatefulWidget {
  Function() onPressed;
  CancelStatusButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<CancelStatusButton> createState() => _CancelStatusButtonState();
}

class _CancelStatusButtonState extends State<CancelStatusButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: Text(
        'Go back',
        style: TextStyle(
          color: themeController.isDarkTheme
              ? Colors.white
              : LightThemeData.primary,
          fontSize: 23.0,
          //fontWeight: FontWeight.bold,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        minimumSize: const Size(double.infinity, 50.0),
        maximumSize: const Size(double.infinity, 50.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppBorders.defaultBorderRadius,
          ),
        ),
      ),
    );
  }
}
