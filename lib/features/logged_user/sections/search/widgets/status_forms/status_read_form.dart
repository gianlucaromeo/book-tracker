import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_read.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/like_dislike_icons_container.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/rating_container.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/status_forms/date_picker_container.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class BookStatusReadForm extends StatefulWidget {
  int? rating;
  DateTime? dateStart;
  DateTime? dateEnd;
  bool? like;

  BookStatusReadForm({Key? key}) : super(key: key);

  @override
  State<BookStatusReadForm> createState() => _BookStatusReadFormState();

  BookStatusRead getBookStatus() {
    return BookStatusRead(
      rating: rating != null ? rating! + 1 : null,
      dateStart: dateStart,
      dateEnd: dateEnd,
      liked: like,
    );
  }
}

class _BookStatusReadFormState extends State<BookStatusReadForm> {
  final ratingsContainer = RatingsContainer();
  final dateStartContainer = DatePickerContainer(title: 'Date start');
  final dateEndContainer = DatePickerContainer(title: 'Date end');
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
    dateEndContainer.addListener(() {
      setState(() {
        widget.dateEnd = dateEndContainer.selectedDateTime;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dateStartContainer,
              dateEndContainer,
            ],
          ),
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
