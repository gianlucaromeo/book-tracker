import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/theme/text_styles.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class TrendingBooksListView extends StatelessWidget {
  const TrendingBooksListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trending Books',
          style: TextStyles.searchPageTrendingBooksTitle,
        ),
        TransparentDivider.h(15.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < 10; i++)
                Padding(
                  padding:
                      const EdgeInsets.only(right: AppPadding.defaultPadding),
                  child: SizedBox(
                    height: 180.0,
                    width: 110.0,
                    child: Column(
                      children: [
                        const Expanded(child: const Placeholder()),
                        TransparentDivider.h(10.0),
                        Text('Book Title $i'),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
