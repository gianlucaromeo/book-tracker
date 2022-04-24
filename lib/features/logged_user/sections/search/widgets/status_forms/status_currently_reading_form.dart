import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/date_picker_container.dart';
import 'package:flutter/material.dart';

class BookStatusToReadForm extends StatefulWidget {
  const BookStatusToReadForm({Key? key}) : super(key: key);

  @override
  State<BookStatusToReadForm> createState() => _BookStatusToReadFormState();
}

class _BookStatusToReadFormState extends State<BookStatusToReadForm> {
  DateTime? selectedDate;
  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DatePickerContainer(title: 'Date start'),
          CheckboxListTile(
            title: Text("Send me a notification"),
            value: checkedValue,
            onChanged: (newValue) {
              setState(() {
                checkedValue = newValue!;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          )
        ],
      ),
    );
  }
}
