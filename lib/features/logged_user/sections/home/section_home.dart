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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BookOfTheDaySection(),
          TransparentDivider.h(AppPadding.defaultPadding),
          const CuriosityTile(
            title: 'The Bible',
            description: 'The most sold book (5 billions printed copies).',
          ),
          TransparentDivider.h(AppPadding.defaultPadding),
          const CuriosityTile(
            title: 'Remembrance of Things Past',
            description:
                'The longest book in the world.\n9\'609\'000 characters, including spaces.',
          ),
          TransparentDivider.h(AppPadding.defaultPadding),
          const DiscoverBooksSection(),
          TransparentDivider.h(AppPadding.defaultPadding),
          const CuriosityTile(
            title: '130 000 000',
            description: 'Books published, according to Google',
          ),
          TransparentDivider.h(AppPadding.defaultPadding),
          const CuriosityTile(
            title: 'The Codex Leicester',
            description:
                'The most expensive book in the world.\nSold for 30.8 million dollars in 1994.',
          ),
          TransparentDivider.h(AppPadding.defaultPadding),
          const CuriosityTile(
            title: 'Did you know that...',
            description:
                '...if you read 20 minutes a day, you would have read 1.8 million words in a year!',
          ),
          TransparentDivider.h(AppPadding.defaultPadding),
        ],
      ),
    );
  }
}
