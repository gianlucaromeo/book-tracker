import 'dart:convert';
import 'package:book_tracker/config/borders.dart';
import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/popular_books_list_view.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/trending_books_list_view.dart';
import 'package:book_tracker/theme/text_styles.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_found.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserSectionSearch extends StatefulWidget {
  const UserSectionSearch({Key? key}) : super(key: key);

  @override
  _UserSectionSearchState createState() => _UserSectionSearchState();
}

class _UserSectionSearchState extends State<UserSectionSearch> {
  final _textController = TextEditingController();
  String _bookToFind = '';

  Future<http.Response> _findBooks() {
    return http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$_bookToFind&maxResults=8&orerBy=relevance')); // TODO
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSearchTextField(),
        TransparentDivider.h(30.0),
        _bookToFind.isEmpty
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        const TrendingBooksListView(),
                        TransparentDivider.h(40.0),
                        const PopularBooksListView(),
                      ],
                    ),
                  ),
                ),
              )
            : buildListOfBooks(),
      ],
    );
  }

  Expanded buildListOfBooks() {
    return Expanded(
      child: Center(
        child: Container(
          color: Colors.transparent,
          child: FutureBuilder(
              future: _findBooks(),
              builder: (BuildContext context,
                  AsyncSnapshot<http.Response> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text(
                      'Please check your connection and try again',
                    );
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      return const Text('Error.');
                    } else {
                      Map<String, dynamic> books =
                          jsonDecode(snapshot.data!.body);
                      if (books['items'] == null) {
                        return const Text('No Items');
                      } else {
                        return ListView.builder(
                          //padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          itemCount: books['items'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return BookFound(
                              book: GoogleBookModel.fromJson(
                                  books['items'][index]),
                            );
                          },
                        );
                      }
                    }
                }
              }),
        ),
      ),
    );
  }

  buildSearchTextField() {
    return TextField(
      controller: _textController,
      onChanged: (newText) {
        setState(() {
          _bookToFind = newText;
        });
      },
      style: TextStyles.searchBookFieldHintText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(AppPadding.defaultPadding),
        hintText: 'Search...',
        /* =========  BORDERS ========= */
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
                Radius.circular(AppBorders.defaultBorderRadius)),
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.1), width: 4)),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
                Radius.circular(AppBorders.defaultBorderRadius)),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2))),
        border: const OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(AppBorders.defaultBorderRadius)),
        ),
        /* ========= END BORDERS ========= */
        /* ========= PREFIX / SUFFIX ICONS ========= */
        prefixIcon: Padding(
          padding: const EdgeInsets.all(AppPadding.defaultPadding / 2),
          child: Icon(
            Icons.search,
            size: 40,
            color: Theme.of(context).iconTheme.color!.withOpacity(0.2),
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(
              bottom: AppPadding.defaultPadding / 2 - 5, // ! TO CENTER
              right: AppPadding.defaultPadding / 2),
          child: IconButton(
            onPressed: () {
              _textController.clear();
              setState(() {
                _bookToFind = '';
              });
            },
            icon: Icon(
              Icons.clear_rounded,
              size: 40,
              color: Theme.of(context).iconTheme.color!.withOpacity(0.2),
            ),
          ),
        ),
        /* ========= END PREFIX / SUFFIX ICONS ========= */
      ),
    );
  }
}
