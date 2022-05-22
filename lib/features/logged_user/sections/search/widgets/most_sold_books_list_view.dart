import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/repository/books_repository.dart';
import 'package:book_tracker/features/logged_user/repository/ibs_to_books_repository.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_found_tile.dart';
import 'package:book_tracker/theme/dark_theme_data.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MostSoldBooksListView extends StatefulWidget {
  const MostSoldBooksListView({Key? key}) : super(key: key);

  @override
  State<MostSoldBooksListView> createState() => _MostSoldBooksListViewState();
}

class _MostSoldBooksListViewState extends State<MostSoldBooksListView> {
  final selectedChips = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Most sold this year',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        TransparentDivider.h(10.0),
        SingleChildScrollView(
          child: Column(
            children: [
              // buildFilterChips(),
              StreamBuilder<QuerySnapshot>(
                stream: IBSToBooksRepository
                    .mostSoldBooks(), // BooksRepository.globalPopularBooks(),
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

  buildFilterChips() {
    return SingleChildScrollView(
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
                    'Chip Text $i',
                    style: TextStyle(
                      color: selectedChips[i]
                          ? themeController.currentThemeMode == ThemeMode.light
                              ? LightThemeData.selectedChipText
                              : DarkThemeData.selectedChipText
                          : themeController.currentThemeMode == ThemeMode.light
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
    );
  }
}
