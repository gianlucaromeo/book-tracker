import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_read.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/like_dislike_icons_container.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/rating_container.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/date_picker_container.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

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
  late final RatingsContainer ratingsContainer;
  late final DatePickerContainer dateStartContainer;
  late final DatePickerContainer dateEndContainer;

  @override
  void initState() {
    super.initState();
    dateStartContainer = DatePickerContainer(
      title: 'Date start',
      showClearLink: true,
      selectedDateTime: widget.bookStatus.dateStart,
    );
    dateEndContainer = DatePickerContainer(
      title: 'Date end',
      showClearLink: true,
      selectedDateTime: widget.bookStatus.dateEnd,
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
    dateEndContainer.addListener(() {
      setState(() {
        widget.bookStatus.dateEnd = dateEndContainer.selectedDateTime;
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
          // ! TODO Check if needed
          //TransparentDivider.h(AppPadding.defaultPadding * 2),
          //likeDislikeIconsContainer,
        ],
      ),
    );
  }
}
