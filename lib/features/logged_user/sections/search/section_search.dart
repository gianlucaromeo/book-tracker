import 'package:book_tracker/features/logged_user/sections/search/widgets/categories/most_sold_books_list_view.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/search_text_field.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/searched_books_list.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/categories/most_popular_books_list_view.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class UserSectionSearch extends StatefulWidget {
  const UserSectionSearch({Key? key}) : super(key: key);

  @override
  _UserSectionSearchState createState() => _UserSectionSearchState();
}

class _UserSectionSearchState extends State<UserSectionSearch> {
  SearchTextField searchTextField = SearchTextField();
  static const _padding = 10.0;

  @override
  void initState() {
    super.initState();
    searchTextField.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        searchTextField,
        TransparentDivider.h(30.0),
        searchTextField.bookToFind.isEmpty
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      _padding, _padding, _padding, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const MostPopularBooksListView(),
                        TransparentDivider.h(40.0),
                        const MostSoldBooksListView(),
                      ],
                    ),
                  ),
                ),
              )
            : Expanded(
                child: SearchedBooksList(
                  bookToFind: searchTextField.bookToFind,
                ),
              ),
      ],
    );
  }
}
