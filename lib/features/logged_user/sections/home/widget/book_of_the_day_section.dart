import 'dart:convert';
import 'package:book_tracker/config/borders.dart';
import 'package:http/http.dart' as http;

import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/util/books_search_util.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_found_tile.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BookOfTheDaySection extends StatelessWidget {
  const BookOfTheDaySection({Key? key}) : super(key: key);

  _findBookOfTheDay() async {
    final book = await BookSearchUtil.findBooks('casa');
    return book;
  }

  @override
  Widget build(BuildContext context) {
    final book = _findBookOfTheDay();
    return Container(
      padding: const EdgeInsets.all(AppPadding.defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border.all(color: Theme.of(context).colorScheme.shadow),
        borderRadius: BorderRadius.circular(AppBorders.defaultBorderRadius),
      ),
      child: FutureBuilder(
          future: BookSearchUtil.findBooks('il'),
          builder: (context, AsyncSnapshot<http.Response> snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Book of the day',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge!.color),
                ),
                TransparentDivider.h(AppPadding.defaultPadding),
                BookFoundTile(
                  book: GoogleBookModel.fromJson(
                    jsonDecode(snap.data!.body)['items'][0],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
