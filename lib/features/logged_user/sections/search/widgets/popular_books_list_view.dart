import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_found.dart';
import 'package:book_tracker/theme/text_styles.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class PopularBooksListView extends StatelessWidget {
  const PopularBooksListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Books',
          style: TextStyles.searchPagePopularBooksTitle,
        ),
        TransparentDivider.h(15.0),
        SingleChildScrollView(
          //scrollDirection: Axis.vertical,
          child: Column(
            children: [
              for (int i = 0; i < 3; i++)
                BookFound(
                  book: GoogleBookModel(),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
