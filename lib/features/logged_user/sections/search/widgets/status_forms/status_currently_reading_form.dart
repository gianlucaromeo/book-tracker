import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_currently_reading.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/rating_container.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/date_picker_container.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookStatusCurrentlyReadingForm extends StatefulWidget {
  final BookStatusCurrentlyReading bookStatus;

  const BookStatusCurrentlyReadingForm({Key? key, required this.bookStatus})
      : super(key: key);

  BookStatusCurrentlyReading getBookStatus() {
    return bookStatus;
  }

  @override
  State<BookStatusCurrentlyReadingForm> createState() =>
      _BookStatusCurrentlyReadingFormState();
}

class _BookStatusCurrentlyReadingFormState
    extends State<BookStatusCurrentlyReadingForm> {
  late RatingsContainer ratingsContainer;
  late DatePickerContainer dateStartContainer;
  late AppLocalizations l10n;

  _init() {
    dateStartContainer = DatePickerContainer(
      title: l10n.datePickerContainerDateStart,
      showClearLink: true,
      selectedDateTime: widget.bookStatus.dateStart,
    );
    ratingsContainer = RatingsContainer(
      selectedRating: widget.bookStatus.rating,
    );
    ratingsContainer.addListener(() {
      setState(() {
        widget.bookStatus.rating = ratingsContainer.selectedRating!;
      });
    });
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
      padding:
          const EdgeInsets.symmetric(horizontal: AppPadding.defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          dateStartContainer,
          TransparentDivider.h(AppPadding.defaultPadding),
          ratingsContainer,
        ],
      ),
    );
  }
}
