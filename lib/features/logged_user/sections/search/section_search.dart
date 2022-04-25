import 'package:book_tracker/features/logged_user/sections/search/widgets/popular_books_list_view.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/search_text_field.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/searched_books_list.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/trending_books_list_view.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class UserSectionSearch extends StatefulWidget {
  const UserSectionSearch({Key? key}) : super(key: key);

  @override
  _UserSectionSearchState createState() => _UserSectionSearchState();
}

class _UserSectionSearchState extends State<UserSectionSearch> {
  SearchTextField searchTextField = SearchTextField();

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
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
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
            : Expanded(
                child: SearchedBooksList(
                  bookToFind: searchTextField.bookToFind,
                ),
              ),
      ],
    );
  }
}
