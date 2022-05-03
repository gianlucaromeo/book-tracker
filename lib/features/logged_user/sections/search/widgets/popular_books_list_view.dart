import 'dart:convert';

import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/book_model.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/repository/books_repository.dart';
import 'package:book_tracker/features/logged_user/sections/search/util/books_search_util.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_found_tile.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PopularBooksListView extends StatefulWidget {
  const PopularBooksListView({Key? key}) : super(key: key);

  @override
  State<PopularBooksListView> createState() => _PopularBooksListViewState();
}

class _PopularBooksListViewState extends State<PopularBooksListView> {
  final selectedChips = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s most popular',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        TransparentDivider.h(15.0),
        SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < 6; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ActionChip(
                            backgroundColor: selectedChips[i]
                                ? Theme.of(context).chipTheme.selectedColor
                                : Theme.of(context).chipTheme.backgroundColor,
                            label: Text(
                              'Fiction $i',
                              style: TextStyle(
                                color: selectedChips[i]
                                    ? themeController.currentThemeMode ==
                                            ThemeMode.light
                                        ? LightThemeData.selectedChipText
                                        : DarkThemeData.selectedChipText
                                    : themeController.currentThemeMode ==
                                            ThemeMode.light
                                        ? LightThemeData.unselectedChipText
                                        : DarkThemeData.unselectedChipText,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                selectedChips[i] = !selectedChips[i];
                              });
                            }),
                      )
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: BooksRepository.globalPopularBooks(),
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
                  if (snap.hasData) {
                    return Column(
                      children: snap.data!.docs.map((bookToReadJson) {
                        GoogleBookModel bookModel = GoogleBookModel.fromJson(
                            bookToReadJson.data() as Json);
                        return BookFoundTile(book: bookModel);
                      }).toList(),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
