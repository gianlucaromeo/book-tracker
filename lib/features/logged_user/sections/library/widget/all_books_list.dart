import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/repository/books_repository.dart';
import 'package:book_tracker/features/logged_user/sections/library/widget/books_currently_reading_list.dart';
import 'package:book_tracker/features/logged_user/sections/library/widget/books_read_list.dart';
import 'package:book_tracker/features/logged_user/sections/library/widget/books_to_read_list.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllBooksList extends StatefulWidget {
  const AllBooksList({Key? key}) : super(key: key);

  @override
  State<AllBooksList> createState() => _AllBooksListState();
}

class _AllBooksListState extends State<AllBooksList> {
  late List<dynamic> data;
  late AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
    data = [
      [
        BooksRepository.booksReadLength(),
        l10n.readBooksTitle,
        const BooksReadList(),
      ],
      [
        BooksRepository.booksCurrentlyReadingLength(),
        l10n.currentlyReadingBooksTitle,
        const BooksCurrentlyReadingList(),
      ],
      [
        BooksRepository.booksToReadLength(),
        l10n.toReadBooksTitle,
        const BooksToReadList(),
      ],
    ];
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: List.generate(
          data.length,
          (index) => _futureBuilder(
            data[index][0],
            data[index][1],
            data[index][2],
            index,
          ),
        ),
      ),
    );
  }

  FutureBuilder<int> _futureBuilder(
      Future<int> future, String title, Widget booksList, int index) {
    return FutureBuilder<int>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<int> snap) {
        if (snap.hasData && snap.data! > 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TransparentDivider.h(10.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TransparentDivider.h(10.0),
              booksList,
              Divider(
                color: Colors.grey.withOpacity(0.2),
              ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TransparentDivider.h(AppPadding.defaultPadding),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TransparentDivider.h(10.0),
              const Text('No books for this section.'),
              Divider(
                color: Colors.grey.withOpacity(0.2),
                height: AppPadding.defaultPadding,
              ),
            ],
          );
        }
      },
    );
  }
}
