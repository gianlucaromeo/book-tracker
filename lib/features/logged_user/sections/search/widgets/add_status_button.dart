import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';

class AddStatusButton extends StatefulWidget {
  final Function() onPressed;
  const AddStatusButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<AddStatusButton> createState() => _AddStatusButtonState();
}

class _AddStatusButtonState extends State<AddStatusButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: const Text(
        'Add Book',
        style: TextStyle(
          color: Colors.white,
          fontSize: 23.0,
          //fontWeight: FontWeight.bold,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: themeController.isDarkTheme
            ? DarkThemeData.onPrimary
            : LightThemeData.primary,
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
