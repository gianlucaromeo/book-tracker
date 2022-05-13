import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';

class ShowBookPageButton extends StatefulWidget {
  Function() onPressed;
  ShowBookPageButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<ShowBookPageButton> createState() => _ShowBookPageButtonState();
}

class _ShowBookPageButtonState extends State<ShowBookPageButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppBorders.defaultBorderRadius,
        ),
        border: Border.all(
          color: themeController.isDarkTheme
              ? Colors.grey
              : LightThemeData.primary,
          //width: 0.5,
        ),
      ),
      child: OutlinedButton(
        onPressed: widget.onPressed,
        child: Text(
          'Show book',
          style: TextStyle(
            color: themeController.isDarkTheme
                ? Colors.white
                : LightThemeData.primary,
            fontSize: 23.0,
            //fontWeight: FontWeight.bold,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          minimumSize: const Size(double.infinity, 50.0),
          maximumSize: const Size(double.infinity, 50.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppBorders.defaultBorderRadius,
            ),
          ),
        ),
      ),
    );
  }
}
