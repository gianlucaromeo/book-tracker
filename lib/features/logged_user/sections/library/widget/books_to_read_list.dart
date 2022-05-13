import 'package:book_tracker/features/logged_user/models/book_model.dart';
import 'package:book_tracker/features/logged_user/repository/books_repository.dart';
import 'package:book_tracker/features/logged_user/sections/library/widget/book_tile.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_to_read.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BooksToReadList extends StatefulWidget {
  const BooksToReadList({Key? key}) : super(key: key);

  @override
  State<BooksToReadList> createState() => _BooksToReadListState();
}

class _BooksToReadListState extends State<BooksToReadList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: BooksRepository.booksToReadStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: snapshot.data!.docs.map((bookJson) {
              BookModel bookModel =
                  BookModel.fromJson(bookJson.data() as Map<String, dynamic>);
              BookStatusToRead bookStatusRead = BookStatusToRead.fromJson(
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
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
