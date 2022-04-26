import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_to_read.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/date_picker_container.dart';
import 'package:flutter/material.dart';

class BookStatusToReadForm extends StatefulWidget {
  DateTime? dateStart;
  bool? sendNotification;
  BookStatusToReadForm({Key? key}) : super(key: key);

  @override
  State<BookStatusToReadForm> createState() => _BookStatusToReadFormState();

  BookStatusToRead getBookStatus() {
    return BookStatusToRead(
      dateStart: dateStart,
      sendNotification: sendNotification,
    );
  }
}

class _BookStatusToReadFormState extends State<BookStatusToReadForm> {
  final dateStartContainer = DatePickerContainer(title: 'Date start');

  @override
  void initState() {
    super.initState();
    dateStartContainer.addListener(() {
      setState(() {
        widget.dateStart = dateStartContainer.selectedDateTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dateStartContainer,
          CheckboxListTile(
            title: Text("Send me a notification"),
            value: widget.sendNotification ?? false,
            onChanged: (newValue) {
              setState(() {
                widget.sendNotification = newValue;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          )
        ],
      ),
    );
  }
}
