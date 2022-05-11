import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';

/// Rounded container which contains info about a date.
/// For example: "Started: 08/12/2022"
class DateInfoUneditable extends StatefulWidget {
  final DateTime dateTime;
  const DateInfoUneditable({Key? key, required this.dateTime})
      : super(key: key);

  @override
  State<DateInfoUneditable> createState() => _DateInfoUneditableState();
}

class _DateInfoUneditableState extends State<DateInfoUneditable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: themeController.isDarkTheme
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(AppBorders.defaultBorderRadius / 2),
      ),
      padding: const EdgeInsets.all(5.0),
      child: Text(
        'Started: ' +
            widget.dateTime
                .toLocal()
                .toIso8601String()
                .split('T')[0]
                .toString(),
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
