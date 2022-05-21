import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/logged_user/models/google_book_model.dart';
import 'package:book_tracker/features/logged_user/repository/books_repository.dart';
import 'package:book_tracker/features/logged_user/repository/ibs_to_books_repository.dart';
import 'package:book_tracker/features/logged_user/sections/search/widgets/book_found_tile.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiscoverBooksSection extends StatefulWidget {
  const DiscoverBooksSection({Key? key}) : super(key: key);

  @override
  State<DiscoverBooksSection> createState() => _DiscoverBooksSectionState();
}

class _DiscoverBooksSectionState extends State<DiscoverBooksSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Discover',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 31,
                fontWeight: FontWeight.bold,
              ),
        ),
        TransparentDivider.h(AppPadding.defaultPadding / 2),
        StreamBuilder<QuerySnapshot>(
          stream: IBSToBooksRepository.mostGiftedBooks(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
            if (snap.hasData) {
              return Column(
                children: snap.data!.docs.map((bookToReadJson) {
                  GoogleBookModel bookModel =
                      GoogleBookModel.fromJson(bookToReadJson.data() as Json);
                  return BookFoundTile(book: bookModel);
                }).toList(),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
