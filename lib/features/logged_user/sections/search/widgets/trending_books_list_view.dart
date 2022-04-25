import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_image.dart';
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
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        TransparentDivider.h(20.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
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
                        const Expanded(
                            child: BookImage(
                          imageUrl:
                              'https://m.media-amazon.com/images/I/41gr3r3FSWL.jpg',
                          size: BookImageSize.trendingBook,
                        )),
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
