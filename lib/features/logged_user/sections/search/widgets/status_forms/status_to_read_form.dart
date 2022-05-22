import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_to_read.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/date_picker_container.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class BookStatusToReadForm extends StatefulWidget {
  final BookStatusToRead bookStatus;

  const BookStatusToReadForm({
    Key? key,
    required this.bookStatus,
  }) : super(key: key);

  @override
  State<BookStatusToReadForm> createState() => _BookStatusToReadFormState();

  BookStatusToRead getBookStatus() {
    return bookStatus;
  }
}

class _BookStatusToReadFormState extends State<BookStatusToReadForm> {
  late final DatePickerContainer dateStartContainer;

  @override
  void initState() {
    super.initState();
    dateStartContainer = DatePickerContainer(
      title: 'Date start',
      showClearLink: true,
      selectedDateTime: widget.bookStatus.dateStart,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TransparentDivider.h(AppPadding.defaultPadding),
          dateStartContainer,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.defaultPadding * 2,
              ),
              child: CheckboxListTile(
                title: const Text(
                  "Send me a notification",
                  maxLines: 2,
                ),
                value: widget.bookStatus.sendNotification ?? false,
                onChanged: (newValue) {
                  setState(() {
                    widget.bookStatus.sendNotification = newValue;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
