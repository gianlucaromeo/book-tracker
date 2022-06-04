import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class CuriosityTile extends StatefulWidget {
  final String title;
  final String description;
  const CuriosityTile(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  State<CuriosityTile> createState() => _CuriosityTileState();
}

class _CuriosityTileState extends State<CuriosityTile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppPadding.defaultPadding),
        decoration: BoxDecoration(
          color: themeController.isDarkTheme
              ? DarkThemeData.secondary
              : LightThemeData.background,
          border: Border.all(color: Theme.of(context).colorScheme.shadow),
          borderRadius: BorderRadius.circular(AppBorders.defaultBorderRadius),
        ),
        child: Column(
          children: [
            // Title
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: LightThemeData.primary,
                    fontSize: 31.0,
                  ),
            ),
            TransparentDivider.h(AppPadding.defaultPadding / 2),
            // Description
            Text(
              widget.description,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
