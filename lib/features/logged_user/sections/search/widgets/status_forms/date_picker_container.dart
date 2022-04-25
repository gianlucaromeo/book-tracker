import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DatePickerContainer extends StatefulWidget {
  final String title;
  const DatePickerContainer({Key? key, required this.title}) : super(key: key);

  @override
  State<DatePickerContainer> createState() => _DatePickerContainerState();
}

class _DatePickerContainerState extends State<DatePickerContainer> {
  DateTime? selectedDateTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 100.0,
      //width: 200.0,
      decoration: BoxDecoration(
        color: themeController.currentThemeMode == ThemeMode.dark
            ? Colors.black
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
        padding: const EdgeInsets.all(AppPadding.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // PICK DATE TITLE
          children: [
            Text(
              widget.title,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 18.0, color: Colors.black.withOpacity(0.3)),
            ),
            TransparentDivider.h(15.0),
            RichText(
              text: TextSpan(
                text: selectedDateTime != null
                    ? selectedDateTime!
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
    if (picked != null && picked != selectedDateTime) {
      setState(() {
        selectedDateTime = picked;
      });
    }
  }
}
