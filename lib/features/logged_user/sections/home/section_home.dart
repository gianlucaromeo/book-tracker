import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/sections/home/widget/book_of_the_day.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class UserSectionHome extends StatelessWidget {
  const UserSectionHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BookOfTheDayTile(),
        TransparentDivider.h(AppPadding.defaultPadding),
      ],
    );
  }
}
