import 'dart:convert';

import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/util/books_search_util.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_image.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class BooksToReadSection extends StatefulWidget {
  const BooksToReadSection({Key? key}) : super(key: key);

  @override
  State<BooksToReadSection> createState() => _ReadSectionState();
}

class _ReadSectionState extends State<BooksToReadSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'To read',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        TransparentDivider.h(10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              for (int i = 0; i < 4; i++)
                FutureBuilder(
                  future: BookSearchUtil.findBooks('occhi'),
                  builder: (context, AsyncSnapshot<http.Response> snap) {
                    final googleBook = GoogleBookModel.fromJson(
                        jsonDecode(snap.data!.body)['items'][i]);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.defaultPadding / 2),
                      child: snap.connectionState == ConnectionState.waiting
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              //height: 200,
                              width: 110,
                              child: Column(
                                children: [
                                  BookImage(
                                    imageUrl: googleBook.volumeInfo!.imageUrl,
                                    size: BookImageSize.setBookStatus,
                                  ),
                                  TransparentDivider.h(10.0),
                                  Text(
                                    '${googleBook.volumeInfo!.title}',
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: themeController
                                        .currentThemeData.textTheme.headline6,
                                  ),
                                ],
                              ),
                            ),
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
