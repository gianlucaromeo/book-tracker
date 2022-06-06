// ignore_for_file: must_be_immutable

import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DatePickerContainer extends StatefulWidget with ChangeNotifier {
  final String title;
  DateTime? selectedDateTime;
  bool showClearLink = true;

  setDateTime(DateTime? dateTime) {
    selectedDateTime = dateTime;
    notifyListeners();
  }

  DatePickerContainer(
      {Key? key,
      required this.title,
      required this.showClearLink,
      this.selectedDateTime})
      : super(key: key);

  @override
  State<DatePickerContainer> createState() => _DatePickerContainerState();
}

class _DatePickerContainerState extends State<DatePickerContainer> {
  late AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: themeController.isDarkTheme
                ? DarkThemeData.background
                : LightThemeData.background,
            borderRadius: BorderRadius.circular(AppBorders.defaultBorderRadius),
            boxShadow: [
              BoxShadow(
                color: themeController.isDarkTheme
                    ? Colors.grey.withOpacity(0.2)
                    : Theme.of(context).shadowColor.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppPadding.defaultPadding / 2 + 2,
              horizontal: AppPadding.defaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // PICK DATE TITLE
              children: [
                Text(
                  widget.title,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: themeController.isDarkTheme
                        ? Colors.grey.withOpacity(0.6)
                        : Colors.black.withOpacity(0.3),
                  ),
                ),
                TransparentDivider.h(15.0),
                RichText(
                  text: TextSpan(
                    text: widget.selectedDateTime != null
                        ? widget.selectedDateTime!
                            .toLocal()
                            .toString()
                            .split(' ')[0]
                            .toString()
                        : l10n.datePickerContainerPickDateTitle,
                    style: const TextStyle(
                      color: LightThemeData.primary,
                      //decoration: TextDecoration.underline,
                      fontSize: 16.0,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = pickDate,
                  ),
                ),
              ],
            ),
          ),
        ),
        TransparentDivider.h(10.0),
        // CLEAR
        if (widget.showClearLink && widget.selectedDateTime != null)
          RichText(
            text: TextSpan(
              text: l10n.datePickerContainerClear,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall!.color,
                decoration: TextDecoration.underline,
                fontSize: 15.0,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => setState(() => widget.setDateTime(null)),
            ),
          ),
      ],
    );
  }

  Future<void> pickDate() async {
    final isDarkTheme = themeController.isDarkTheme;
    final DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: isDarkTheme
                  ? DarkThemeData.primary
                  : LightThemeData.primary, // header background color
              onPrimary: isDarkTheme
                  ? Colors.white
                  : Colors.white, // header text color
              surface:
                  isDarkTheme ? Colors.black.withOpacity(0.5) : Colors.white,
              onSurface: isDarkTheme
                  ? DarkThemeData.primary
                  : LightThemeData.primary, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: isDarkTheme
                    ? Colors.white
                    : LightThemeData.primary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.now().add(
        const Duration(hours: 1),
      ),
      firstDate: DateTime.now().subtract(const Duration(hours: 24 * 365 * 10)),
      lastDate: DateTime.now().add(
        const Duration(hours: 24 * 365 * 4),
      ),
    );
    if (picked != null && picked != widget.selectedDateTime) {
      setState(() {
        widget.setDateTime(picked);
      });
    }
  }
}
