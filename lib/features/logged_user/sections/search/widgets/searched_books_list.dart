import 'dart:convert';

import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/util/books_search_util.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_found_tile.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchedBooksList extends StatelessWidget {
  final String bookToFind;
  const SearchedBooksList({Key? key, required this.bookToFind})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: FutureBuilder(
          future: BookSearchUtil.findBooks(bookToFind),
          builder:
              (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: Text(
                    'Connection Error',
                  ),
                );
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return const Center(child: Text('Error.'));
                } else {
                  Map<String, dynamic> books = jsonDecode(snapshot.data!.body);
                  if (books['items'] == null) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TransparentDivider.h(AppPadding.defaultPadding),
                        Text(
                          AppLocalizations.of(context)!.searchPageNoItemsInfo,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        TransparentDivider.w(double.infinity),
                        TransparentDivider.h(AppPadding.defaultPadding),
                        Lottie.asset(
                          'assets/logged_user/no_items_error.json',
                          height: 250,
                        ),
                        TransparentDivider.h(AppPadding.defaultPadding),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      itemCount: books['items'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return BookFoundTile(
                          book: GoogleBookModel.fromJson(books['items'][index]),
                        );
                      },
                      physics: const BouncingScrollPhysics(),
                    );
                  }
                }
            }
          }),
    );
  }
}
