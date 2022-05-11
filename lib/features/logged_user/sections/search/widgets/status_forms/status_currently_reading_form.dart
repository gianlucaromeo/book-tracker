import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_currently_reading.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/like_dislike_icons_container.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/rating_container.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/date_picker_container.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class BookStatusCurrentlyReadingForm extends StatefulWidget {
  int? rating;
  DateTime? dateStart;
  bool? like;

  BookStatusCurrentlyReadingForm({Key? key}) : super(key: key);

  BookStatusCurrentlyReading getBookStatus() {
    return BookStatusCurrentlyReading(
      rating: rating != null ? rating! + 1 : null,
      dateStart: dateStart,
      liked: like,
    );
  }

  @override
  State<BookStatusCurrentlyReadingForm> createState() =>
      _BookStatusCurrentlyReadingFormState();
}

class _BookStatusCurrentlyReadingFormState
    extends State<BookStatusCurrentlyReadingForm> {
  final ratingsContainer = RatingsContainer();
  final dateStartContainer = DatePickerContainer(
    title: 'Date start',
    showClearLink: true,
  );
  final likeDislikeIconsContainer = LikeDislikeIconsContainer();

  @override
  void initState() {
    super.initState();
    ratingsContainer.addListener(() {
      setState(() {
        widget.rating = ratingsContainer.selectedRating;
      });
    });
    dateStartContainer.addListener(() {
      setState(() {
        widget.dateStart = dateStartContainer.selectedDateTime;
      });
    });
    likeDislikeIconsContainer.addListener(() {
      setState(() {
        widget.like = likeDislikeIconsContainer.like;
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
          TransparentDivider.h(AppPadding.defaultPadding * 2),
          ratingsContainer,
          // ! TODO Check if needed
          //TransparentDivider.h(AppPadding.defaultPadding * 2),
          //likeDislikeIconsContainer,
        ],
      ),
    );
  }
}
