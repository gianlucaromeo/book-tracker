import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_read.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/rating_container.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/date_picker_container.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookStatusReadForm extends StatefulWidget {
  final BookStatusRead bookStatus;

  const BookStatusReadForm({Key? key, required this.bookStatus})
      : super(key: key);

  @override
  State<BookStatusReadForm> createState() => _BookStatusReadFormState();

  BookStatusRead getBookStatus() {
    return bookStatus;
  }
}

class _BookStatusReadFormState extends State<BookStatusReadForm> {
  late RatingsContainer ratingsContainer;
  late DatePickerContainer dateStartContainer;
  late DatePickerContainer dateEndContainer;
  late AppLocalizations l10n;

  _init() {
    ratingsContainer = RatingsContainer(
      selectedRating: widget.bookStatus.rating,
    );
    dateStartContainer = DatePickerContainer(
      title: l10n.datePickerContainerDateStart,
      showClearLink: true,
      selectedDateTime: widget.bookStatus.dateStart,
    );
    dateEndContainer = DatePickerContainer(
      title: l10n.datePickerContainerDateEnd,
      showClearLink: true,
      selectedDateTime: widget.bookStatus.dateEnd,
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
    dateEndContainer.addListener(() {
      setState(() {
        widget.bookStatus.dateEnd = dateEndContainer.selectedDateTime;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              dateStartContainer,
              dateEndContainer,
            ],
          ),
          TransparentDivider.h(AppPadding.defaultPadding),
          ratingsContainer,
        ],
      ),
    );
  }
}
