import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DatePickerContainer extends StatefulWidget with ChangeNotifier {
  final String title;
  DateTime? selectedDateTime;

  setDateTime(DateTime? dateTime) {
    selectedDateTime = dateTime;
    notifyListeners();
  }

  DatePickerContainer({Key? key, required this.title}) : super(key: key);

  @override
  State<DatePickerContainer> createState() => _DatePickerContainerState();
}

class _DatePickerContainerState extends State<DatePickerContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //height: 100.0,
          //width: 200.0,
          decoration: BoxDecoration(
            color: themeController.isDarkTheme
                ? DarkThemeData.surface.withOpacity(0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(AppBorders.defaultBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.1),
                blurRadius: 2,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.defaultPadding / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // PICK DATE TITLE
              children: [
                Text(
                  widget.title,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18.0,
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
                            .toIso8601String()
                            .split('T')[0]
                            .toString()
                        : 'Pick a date',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.titleMedium!.color,
                      //decoration: TextDecoration.underline,
                      fontSize: 21.0,
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
        RichText(
          text: TextSpan(
            text: 'Clear',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall!.color,
              decoration: TextDecoration.underline,
              fontSize: 18.0,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => setState(() {
                    widget.setDateTime(null);
                  }),
          ),
        ),
      ],
    );
  }

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(
        Duration(hours: 1),
      ),
      firstDate: DateTime.now().add(Duration(hours: 1)),
      lastDate: DateTime.now().add(
        Duration(hours: 24 * 365 * 4),
      ),
    );
    if (picked != null && picked != widget.selectedDateTime) {
      setState(() {
        widget.setDateTime(picked);
      });
    }
  }
}
