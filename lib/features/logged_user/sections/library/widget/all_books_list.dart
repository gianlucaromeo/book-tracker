import 'package:book_tracker/features/logged_user/models/book_model.dart';
import 'package:book_tracker/features/logged_user/repository/books_repository.dart';
import 'package:book_tracker/features/logged_user/sections/library/widget/book_tile.dart';
import 'package:book_tracker/features/logged_user/models/book_status/book_status_to_read.dart';
import 'package:book_tracker/features/logged_user/sections/library/widget/books_currently_reading_list.dart';
import 'package:book_tracker/features/logged_user/sections/library/widget/books_read_list.dart';
import 'package:book_tracker/features/logged_user/sections/library/widget/books_to_read_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllBooksList extends StatefulWidget {
  const AllBooksList({Key? key}) : super(key: key);

  @override
  State<AllBooksList> createState() => _AllBooksListState();
}

class _AllBooksListState extends State<AllBooksList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Text('Read'),
          BooksReadList(),
          Divider(
            color: Colors.grey.withOpacity(0.2),
          ),
          Text('Currently Reading'),
          BooksCurrentlyReadingList(),
          Divider(
            color: Colors.grey.withOpacity(0.2),
          ),
          Text('To Read'),
          BooksToReadList(),
          Divider(
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
