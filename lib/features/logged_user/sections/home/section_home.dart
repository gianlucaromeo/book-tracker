import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/sections/home/widget/book_of_the_day_section.dart';
import 'package:book_tracker/features/logged_user/sections/home/widget/curiosity_tile.dart';
import 'package:book_tracker/features/logged_user/sections/home/widget/discover_books_section.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class UserSectionHome extends StatelessWidget {
  const UserSectionHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BookOfTheDaySection(),
            TransparentDivider.h(AppPadding.defaultPadding),
            DiscoverBooksSection(),
            TransparentDivider.h(AppPadding.defaultPadding),
            CuriosityTile(
              title: '130 000 000',
              description: 'Books published, according to Google',
            ),
            TransparentDivider.h(AppPadding.defaultPadding),
            CuriosityTile(
              title: 'The Bible',
              description: 'The most sold book.\n5 billions printed copies.',
            ),
          ],
        ),
      ),
    );
  }
}
