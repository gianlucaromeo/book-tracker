import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_to_read.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/date_picker_container.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

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
  late DatePickerContainer dateStartContainer;
  late AppLocalizations l10n;

  _init() {
    dateStartContainer = DatePickerContainer(
      title: l10n.datePickerContainerDateStart,
      showClearLink: true,
      selectedDateTime: widget.bookStatus.dateStart,
    );
    dateStartContainer.addListener(() {
      setState(() {
        widget.bookStatus.dateStart = dateStartContainer.selectedDateTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
    _init();
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TransparentDivider.h(4.0),

          dateStartContainer,
          TransparentDivider.h(4.0),
          Expanded(
            child: Lottie.asset(
              'assets/logged_user/book_status_to_read.json',
            ),
          ),
          TransparentDivider.h(4.0),
          //_buildSendNotificationCheckbox(),
        ],
      ),
    );
  }

  _buildSendNotificationCheckbox() {
    return Expanded(
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
    );
  }
}
