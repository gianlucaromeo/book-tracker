import 'package:book_tracker/features/logged_user/models/book_model.dart';
import 'package:book_tracker/features/logged_user/repository/books_repository.dart';
import 'package:book_tracker/features/logged_user/sections/library/common/no_books_animation.dart';
import 'package:book_tracker/features/logged_user/sections/library/widget/book_tile.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_currently_reading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BooksCurrentlyReadingList extends StatefulWidget {
  const BooksCurrentlyReadingList({Key? key}) : super(key: key);

  @override
  State<BooksCurrentlyReadingList> createState() =>
      _BooksCurrentlyReadingListState();
}

class _BooksCurrentlyReadingListState extends State<BooksCurrentlyReadingList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: BooksRepository.booksCurrentlyReadingStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.size > 0
              ? Column(
                  children: snapshot.data!.docs.map((bookJson) {
                    BookModel bookModel = BookModel.fromJson(
                        bookJson.data() as Map<String, dynamic>);
                    BookStatusCurrentlyReading bookStatusRead =
                        BookStatusCurrentlyReading.fromJson(
                            bookJson['bookStatus'] as Map<String, dynamic>);
                    bookModel.bookStatus = bookStatusRead;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: BookTile(
                            bookModel: bookModel,
                          ),
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    );
                  }).toList(),
                )
              : const NoBooksAnimation();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
