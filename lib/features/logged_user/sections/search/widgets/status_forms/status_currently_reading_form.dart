import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_currently_reading.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/rating_container.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/date_picker_container.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class BookStatusCurrentlyReadingForm extends StatefulWidget {
  final BookStatusCurrentlyReading bookStatus;

  BookStatusCurrentlyReadingForm({Key? key, required this.bookStatus})
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
  late final RatingsContainer ratingsContainer;
  late final DatePickerContainer dateStartContainer;

  @override
  void initState() {
    super.initState();
    dateStartContainer = DatePickerContainer(
      title: 'Date start',
      showClearLink: true,
      selectedDateTime: widget.bookStatus.dateStart,
    );
    ratingsContainer = RatingsContainer(
      selectedRating: widget.bookStatus.rating,
    );
    ratingsContainer.addListener(() {
      setState(() {
        widget.bookStatus.rating = ratingsContainer.selectedRating! + 1;
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
          // ! TODO Check if needed
          //TransparentDivider.h(AppPadding.defaultPadding * 2),
          //likeDislikeIconsContainer,
        ],
      ),
    );
  }
}
