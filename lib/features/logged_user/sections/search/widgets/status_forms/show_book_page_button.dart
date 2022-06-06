import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowBookPageButton extends StatefulWidget {
  final Function() onPressed;
  const ShowBookPageButton({Key? key, required this.onPressed})
      : super(key: key);

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
        color: Colors.transparent,
        border: Border.all(
          color: themeController.isDarkTheme
              ? DarkThemeData.secondary
              : LightThemeData.primary,
          //width: 0.5,
        ),
      ),
      child: OutlinedButton(
        onPressed: widget.onPressed,
        child: Text(
          AppLocalizations.of(context)!.searchedBookPageShowBookButtonText,
          style: TextStyle(
            color: themeController.isDarkTheme
                ? Colors.white
                : LightThemeData.primary,
            fontSize: 23.0,
            //fontWeight: FontWeight.bold,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: themeController.isDarkTheme
              ? DarkThemeData.background
              : LightThemeData.background,
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
